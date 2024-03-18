return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  opts = {}, -- automatically calls `require("lazydocker").setup()`
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("lazydocker").setup()
    popup_window = {
      enter = true,
      focusable = true,
      zindex = 40,
      position = "50%",
      relative = "editor",
      size = {
        width = "90%",
        height = "90%",
      },
      buf_options = {
        modifiable = true,
        readonly = false,
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        winblend = 0,
      },
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = {
          top = " Lazydocker ",
        },
      },
    }
    vim.keymap.set("n", "<leader>k", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker", noremap = true, silent = true })
  end,
}
