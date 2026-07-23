return {
  dir = vim.fn.expand("~/dev/journal.nvim"),
  name = "journal.nvim",
  cmd = "Journal",
  config = function()
    require("journal").setup({
      dir = vim.fn.expand("~/journal"),
    })
  end,
}
