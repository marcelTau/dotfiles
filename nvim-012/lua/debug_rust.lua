local M = {}

local function get_test_name()
  local buf = vim.api.nvim_get_current_buf()
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1

  for line = current_line, 0, -1 do
    local line_content = vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1]

    if line_content and (line_content:match("#%[test%]") or line_content:match("#%[tokio::test%]")) then
      local next_line = vim.api.nvim_buf_get_lines(buf, line + 1, line + 2, false)[1]
      if next_line then
        local function_name = next_line:match("fn%s+([%w_]+)%s*%(")
        if function_name then
          return function_name
        end
      end
    end
  end

  vim.notify("No test function found", vim.log.levels.WARN)
end

local function find_cargo_workspace()
  local current_dir = vim.fn.expand("%:p:h")

  while current_dir and current_dir ~= "/" do
    if vim.fn.glob(current_dir .. "/Cargo.toml") ~= "" then
      return current_dir
    end

    local parent = vim.fn.fnamemodify(current_dir, ":h")
    if parent == current_dir then
      break
    end
    current_dir = parent
  end

  vim.notify("No Cargo.toml found", vim.log.levels.WARN)
end

local function get_executable_name(test_function, cargo_dir)
  if not test_function or not cargo_dir then
    return nil
  end

  local output = vim.system({ "cargo", "test", "--no-run", "-v", test_function }, { text = true }):wait()
  for line in (output.stderr or ""):gmatch("[^\n]+") do
    if line:find("Executable") and line:find(cargo_dir) then
      return line:match("`(.-)`")
    end
  end
end

function M.my_debug()
  vim.cmd("silent! packadd termdebug")

  local test_function = get_test_name()
  local cargo_dir = find_cargo_workspace()
  local executable_name = get_executable_name(test_function, cargo_dir)

  if not executable_name then
    vim.notify("Could not determine test executable", vim.log.levels.ERROR)
    return
  end

  for _, cmd in ipairs({
    "Termdebug " .. executable_name,
    "wincmd p",
    "Break",
    "Program",
    "call TermDebugSendCommand('set print pretty on')",
    "Run",
  }) do
    vim.cmd(cmd)
  end
end

vim.g.termdebug_config = {
  command = "rust-gdb",
  wide = 1,
}

vim.api.nvim_create_user_command("DD", function()
  M.my_debug()
end, {})

return M
