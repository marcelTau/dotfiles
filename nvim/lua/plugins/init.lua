-- Basic plugins which don't need any configuration
-- For plugins that need to be configured, create a file in lua/plugins. It will get loaded automatically

return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  "numToStr/Comment.nvim",
  -- {
  --   dir = "/home/marcel/.config/nvim/lua/plugins",
  --   name = "aws_logs",
  --   config = function()
  --     require('plugins.aws_logs').setup()
  --   end,
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  -- },
}
