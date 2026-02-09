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

  local first_remote = nil
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
    vim.notify("Failed to fetch branch '" .. branch .. "' from remote '" .. remote .. "': " .. reason, vim.log.levels.ERROR)
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

  local ok_telescope, pickers = pcall(require, "telescope.pickers")
  if not ok_telescope then
    vim.notify("Telescope is not available", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local mrs, err = fetch_open_mrs()
  if err then
    vim.notify(err, vim.log.levels.ERROR)
    return
  end

  if not mrs or vim.tbl_isempty(mrs) then
    vim.notify("No open merge requests found", vim.log.levels.INFO)
    return
  end

  pickers
    .new({}, {
      prompt_title = "GitLab Merge Requests",
      finder = finders.new_table({
        results = mrs,
        entry_maker = function(mr)
          local display = string.format("!%s  %s -> %s  %s", mr.iid, mr.source_branch, mr.target_branch, mr.title)
          return {
            value = mr,
            display = display,
            ordinal = display,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if selection and selection.value then
            checkout_branch(selection.value.source_branch)
          end
        end)
        return true
      end,
    })
    :find()
end

vim.api.nvim_create_user_command("GS", function()
  M.open_picker()
end, {
  desc = "Switch branches from GitLab merge requests",
})

return M
