-- Define an augroup for Rust filetype-specific commands
vim.api.nvim_create_augroup('RustFileTypeMappings', { clear = true })

-- Setup autocommands for Rust filetype
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  group = 'RustFileTypeMappings',
  callback = function()
    -- Define key mappings for Rust files
    vim.api.nvim_set_keymap('n', '<leader>b', ':Compile<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>t', ':RustTest<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>r', ':Cargo run<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>gt', ':RustTest!<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>f', ':RustFmt<CR>', { noremap = true, silent = true })
    vim.g.rustfmt_autosave = 1
  end,
})

vim.api.nvim_create_augroup('CargoTomlMappings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toml',
  group = 'CargoTomlMappings',
  callback = function()
    local crates = require('crates')
    vim.keymap.set("n", "<leader>sf", crates.show_features_popup, opts)
  end
})

vim.cmd('packadd termdebug')
