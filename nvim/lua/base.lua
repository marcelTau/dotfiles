vim.api.nvim_set_keymap('i', 'ö', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ö', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', 'ö', '<C-\\><C-n>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>H', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>L', ':wincmd l<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'J', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '5k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', '5k', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>7', ':nohl<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>7', ':nohl<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-f>', ':tabp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':tabn<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>n', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':cprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>n', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', ':cprev<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>+', ':vertical resize +10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>-', ':vertical resize -10<CR>', { noremap = true, silent = true })

vim.opt.number = false
vim.opt.conceallevel = 0
-- vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes:1'
vim.opt.scrolloff = 2
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.swapfile = false

vim.opt.undofile = true
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.cmdheight = 0
vim.opt.inccommand = 'split'
vim.opt.clipboard = 'unnamedplus'
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.termguicolors = true

-- vim.opt.guicursor = ""

vim.api.nvim_set_hl(0, "Comment", { fg = "#ff8800", italic = true })
