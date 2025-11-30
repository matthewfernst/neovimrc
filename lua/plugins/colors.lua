--function ColorMyPencils(color)
--    color = color or "catppuccin-mocha"
--    vim.cmd.colorscheme(color)
--
--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--end

return {
--  {
--    "rose-pine/neovim",
--    name = "rose-pine",
--    config = function()
--      require("rose-pine").setup({
--        disable_background = true,
--      })
--
--      --            vim.cmd("colorscheme rose-pine")
--
--      --            ColorMyPencils()
--    end,
--  },
 -- {
 --   "catppuccin/nvim",
 --   name = "catppuccin",
 --   priority = 1000,
 --   config = function()
 --     vim.cmd.colorscheme("catppuccin")
 --   end,
 -- },
  { 'dasupradyumna/midnight.nvim',
    lazy = false,
    priority = 1000,
   config = function()
     vim.cmd.colorscheme("midnight")
   end,
  }
}
