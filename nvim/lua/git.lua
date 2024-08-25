require('gitsigns').setup()

vim.api.nvim_set_keymap('n', '<leader>gvd', ':Gvdiffsplit<CR>', { noremap = true, silent = false })
