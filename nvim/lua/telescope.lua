local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>', '', {
    noremap = true,
  silent = true,
  callback = function()
    builtin.git_files(themes.get_dropdown({
      previewer = false,  -- Disable the previewer for this theme
      prompt_title = 'Git Files',  -- Custom title for the prompt
    }))
  end,
})
vim.keymap.set('n', '<leader>ds', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>hs', builtin.lsp_references, {})