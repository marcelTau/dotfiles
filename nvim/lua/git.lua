require('gitsigns').setup()

vim.api.nvim_set_keymap('n', '<leader>gvd', ':Gvdiffsplit<CR>', { noremap = true, silent = false })

-- GitLab Merge Request plugin
local function create_mr_buffer()
  -- Create a new scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)

  -- Set buffer options
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'gitcommit'

  -- Add template content
  local lines = {
    '',
    '',
    '',
  }
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Position cursor on line 1 for title
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  vim.cmd('startinsert')

  -- Create buffer-local command to submit
  vim.api.nvim_buf_create_user_command(buf, 'MRSubmit', function()
    local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local title = all_lines[1] or ''
    local description = table.concat(vim.list_slice(all_lines, 3), '\n')

    if title == '' then
      vim.notify('MR title cannot be empty', vim.log.levels.ERROR)
      return
    end

    -- Escape special shell characters in title and description
    title = title:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('`', '\\`'):gsub('%$', '\\$')
    description = description:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('`', '\\`'):gsub('%$', '\\$'):gsub('\n', '\\n')

    -- Detect default branch
    local default_branch = vim.fn.system('git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed "s@^refs/remotes/origin/@@"'):gsub('%s+', '')
    if default_branch == '' then
      default_branch = 'master'
    end

    local cmd = string.format(
      'git push -u origin HEAD -o merge_request.create -o merge_request.title="%s" -o merge_request.description="%s" -o merge_request.target=%s',
      title,
      description,
      default_branch
    )

    -- Close the buffer
    vim.api.nvim_buf_delete(buf, { force = true })

    -- Run the command
    vim.fn.jobstart(cmd, {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.schedule(function()
            vim.notify('Merge request created successfully!', vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify('Failed to create merge request', vim.log.levels.ERROR)
          end)
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          vim.schedule(function()
            for _, line in ipairs(data) do
              if line ~= '' then
                vim.notify(line, vim.log.levels.WARN)
              end
            end
          end)
        end
      end,
    })
  end, {})

  -- Add keybind for quick submit
  vim.keymap.set('n', '<leader>w', ':MRSubmit<CR>', { buffer = buf, silent = true })

  vim.notify('Write title on line 1, description from line 3. Use :MRSubmit or <leader>w to create MR', vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('MR', create_mr_buffer, {})
