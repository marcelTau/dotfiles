-- Create an augroup for Prettier
local prettier_group = vim.api.nvim_create_augroup("PrettierGroup", { clear = true })

-- Set up an autocommand to run Prettier before saving specific file types
vim.api.nvim_create_autocmd("BufWritePre", {
  group = prettier_group,
  pattern = { "*.tsx", "*.ts", "*.js", "*.html", "*.css" },
  command = ":Prettier<CR>",
})

-- Set up autocommands for indentation settings based on file type
local indent_settings = function()
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
  vim.bo.expandtab = true
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "tsx" },
  callback = indent_settings,
})