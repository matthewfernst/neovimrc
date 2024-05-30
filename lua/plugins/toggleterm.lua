return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Setting the default terminal configuration
    })

    -- Define a function to get the current working directory
    local function toggleterm_with_cwd()
      local cwd = vim.fn.getcwd()
      vim.cmd("ToggleTerm size=40 direction=float dir=" .. cwd)
    end

    -- Map the key to the function that opens ToggleTerm with the current directory
    vim.keymap.set("n", "<leader>tm", toggleterm_with_cwd, { desc = "Toggle Terminal in Current Directory" })
  end,
}
