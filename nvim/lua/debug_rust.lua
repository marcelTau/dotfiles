local M = {}

local getTestName = function ()
    local buf = vim.api.nvim_get_current_buf()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor_pos[1] - 1

    -- print("Current line: " .. current_line)
    --
    for line = current_line, 0, -1 do
        local line_content = vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1]

        if line_content:match("#%[test%]") or line_content:match("#%[tokio::test%]") then
            -- print("found test line")
            local next_line_content = vim.api.nvim_buf_get_lines(buf, line + 1, line + 2, false)[1]
            -- print("fn line = " .. next_line_content)

            local function_name = next_line_content:match("fn%s+([%w_]+)%s*%(")

            if function_name then
                -- print("function name = " .. function_name)
                return function_name
            end
        end
    end

    print("No test function found :(")
    return nil
end

local findCargoWorkspace = function ()
    local current_dir = vim.fn.expand('%:p:h')

    while current_dir do
        if vim.fn.glob(current_dir .. '/Cargo.toml') ~= '' then
            -- print("CUR: " .. current_dir)
            return "/" .. current_dir:match(".*/(.*)$")
        end

        current_dir = vim.fn.fnamemodify(current_dir, ':h')
        if current_dir == '/' then break end
    end
    print("No cargo.toml found")
    return nil
end

local getExecutableName = function (test_function, cargo_dir)
    local output = vim.system({ "cargo", "test", "--no-run", "-v", test_function}, { text = true }):wait()

    for line in output.stderr:gmatch("[^\n]+") do
        if line:find("Executable") and line:find(cargo_dir) then
            return line:match("`(.-)`")
        end
    end

    return nil
end

M.my_debug = function ()
    print("working")
    local test_function = getTestName()
    local cargo_dir = findCargoWorkspace()
    local executable_name = getExecutableName(test_function, cargo_dir)
    local termdebug_command = "Termdebug " .. executable_name

    local commands = { termdebug_command, "wincmd p", "Break", "Program",  "call TermDebugSendCommand('set print pretty on')", "Run" }

    for _, cmd in ipairs(commands) do
        vim.cmd(cmd)
    end
end

local config = { command = "rust-gdb", wide = 1 }
vim.g.termdebug_config = config
vim.api.nvim_create_user_command(
    'DD',
    function() M.my_debug() end,
    {}
)

return M
