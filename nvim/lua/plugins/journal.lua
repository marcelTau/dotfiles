return {
  url = "git@github.com:marcelTau/journal.nvim.git",
  name = "journal.nvim",
  cmd = "Journal",
  config = function()
    require("journal").setup({
      dir = vim.fn.expand("~/journal"),
    })
  end,
}
