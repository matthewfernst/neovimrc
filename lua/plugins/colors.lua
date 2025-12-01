return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     require('tokyonight').setup({
  --       style = "day"
  --     })
  --     vim.cmd[[colorscheme tokyonight]]
  --   end
  -- }
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedarkpro").setup({
      colors = {
        bg = "#21252b",
      }
      })
      vim.cmd [[colorscheme onedark]]
    end
  }
}
