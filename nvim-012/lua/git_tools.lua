local M = {}

local function run_command(cmd)
  if vim.system then
    local result = vim.system(cmd, { text = true }):wait()
    return result.code, result.stdout or "", result.stderr or ""
  end

  local output = vim.fn.system(cmd)
  return vim.v.shell_error, output or "", ""
end

local function split_lines(text)
  local lines = {}
  for line in (text or ""):gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end
  return lines
end

local function detect_remote()
  local code, stdout = run_command({ "git", "remote" })
  if code ~= 0 then
    return "origin"
  end

  local first_remote
  for _, remote in ipairs(split_lines(stdout)) do
    if remote ~= "" then
      if remote == "origin" then
        return "origin"
      end
      if not first_remote then
        first_remote = remote
      end
    end
  end

  return first_remote or "origin"
end

local function decode_json(text)
  if vim.json and vim.json.decode then
    return vim.json.decode(text)
  end
  return vim.fn.json_decode(text)
end

local function fetch_open_mrs()
  local endpoint = "projects/:id/merge_requests?scope=created_by_me&state=opened&order_by=updated_at&sort=desc&per_page=100"
  local code, stdout, stderr = run_command({ "glab", "api", endpoint })

  if code ~= 0 then
    local reason = (stderr ~= "" and stderr) or stdout
    return nil, "glab failed: " .. (reason ~= "" and reason or "unknown error")
  end

  local ok, decoded = pcall(decode_json, stdout)
  if not ok or type(decoded) ~= "table" then
    return nil, "failed to parse GitLab MR JSON response"
  end

  local mrs = {}
  for _, mr in ipairs(decoded) do
    if mr.source_branch and mr.title then
      table.insert(mrs, {
        iid = tostring(mr.iid or "?"),
        title = mr.title,
        source_branch = mr.source_branch,
        target_branch = mr.target_branch or "",
        web_url = mr.web_url or "",
      })
    end
  end

  return mrs, nil
end

local function checkout_branch(branch)
  if not branch or branch == "" then
    vim.notify("No branch selected", vim.log.levels.ERROR)
    return
  end

  local switch_code = run_command({ "git", "switch", branch })
  if switch_code == 0 then
    vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
    return
  end

  local remote = detect_remote()

  local fetch_code, _, fetch_err = run_command({ "git", "fetch", remote, branch })
  if fetch_code ~= 0 then
    local reason = fetch_err ~= "" and fetch_err or "unable to fetch remote branch"
    vim.notify(("Failed to fetch branch '%s' from remote '%s': %s"):format(branch, remote, reason), vim.log.levels.ERROR)
    return
  end

  local track_code, _, track_err = run_command({
    "git",
    "switch",
    "--track",
    "-c",
    branch,
    remote .. "/" .. branch,
  })

  if track_code ~= 0 then
    local retry_code, _, retry_err = run_command({ "git", "switch", branch })
    if retry_code ~= 0 then
      local reason = track_err ~= "" and track_err or retry_err
      vim.notify("Failed to switch to branch '" .. branch .. "': " .. (reason ~= "" and reason or "unknown error"), vim.log.levels.ERROR)
      return
    end
  end

  vim.notify("Switched to branch: " .. branch, vim.log.levels.INFO)
end

function M.open_picker()
  if vim.fn.executable("glab") == 0 then
    vim.notify("glab CLI is not installed or not in PATH", vim.log.levels.ERROR)
    return
  end

  local mrs, err = fetch_open_mrs()
  if err then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  if not mrs or vim.tbl_isempty(mrs) then
    vim.notify("No open merge requests found", vim.log.levels.INFO)
    return
  end

  vim.ui.select(mrs, {
    prompt = "GitLab Merge Requests",
    format_item = function(mr)
      return string.format("!%s  %s -> %s  %s", mr.iid, mr.source_branch, mr.target_branch, mr.title)
    end,
  }, function(choice)
    if choice then
      checkout_branch(choice.source_branch)
    end
  end)
end

local function create_mr_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "gitcommit"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "",
    "",
    "",
  })

  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.cmd("startinsert")

  vim.api.nvim_buf_create_user_command(buf, "MRSubmit", function()
    local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local title = all_lines[1] or ""
    local description = table.concat(vim.list_slice(all_lines, 3), "\n")

    if title == "" then
      vim.notify("MR title cannot be empty", vim.log.levels.ERROR)
      return
    end

    title = title:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("`", "\\`"):gsub("%$", "\\$")
    description = description:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("`", "\\`"):gsub("%$", "\\$"):gsub("\n", "\\n")

    local default_branch = vim.fn.system('git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed "s@^refs/remotes/origin/@@"'):gsub("%s+", "")
    if default_branch == "" then
      default_branch = "master"
    end

    local cmd = string.format(
      'git push -u origin HEAD -o merge_request.create -o merge_request.title="%s" -o merge_request.description="%s" -o merge_request.target=%s',
      title,
      description,
      default_branch
    )

    vim.api.nvim_buf_delete(buf, { force = true })

    vim.fn.jobstart(cmd, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.schedule(function()
            vim.notify("Merge request created successfully!", vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("Failed to create merge request", vim.log.levels.ERROR)
          end)
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          vim.schedule(function()
            for _, line in ipairs(data) do
              if line ~= "" then
                vim.notify(line, vim.log.levels.WARN)
              end
            end
          end)
        end
      end,
    })
  end, {})

  vim.keymap.set("n", "<leader>w", "<Cmd>MRSubmit<CR>", { buffer = buf, silent = true })
  vim.notify("Write title on line 1, description from line 3. Use :MRSubmit or <leader>w to create MR", vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_user_command("MR", create_mr_buffer, {
    desc = "Create a GitLab merge request for the current branch",
  })

  vim.api.nvim_create_user_command("GS", function()
    M.open_picker()
  end, {
    desc = "Switch branches from GitLab merge requests",
  })
end

return M
