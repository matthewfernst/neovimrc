return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- Ensure this runs after lspconfig so the LspAttach autocmds are ready
    dependencies = { "neovim/nvim-lspconfig" }, 
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      
      -- 1. Setup Mason-LSPConfig
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "cmake",
          "dockerls",
          "jsonls",
          "ts_ls", -- FIXED: Renamed from 'tsserver'
          "marksman",
          "pyright",
          "rust_analyzer", -- Added to ensure it is installed
        },
      })

      -- 2. Define Handlers
      -- This function runs for every server Mason installs.
      -- It replaces the manual lspconfig.server.setup({}) calls.
      mason_lspconfig.setup_handlers({
        -- The default handler for all servers
        function(server_name)
          local opts = {}

          -- Custom config for Clangd
          if server_name == "clangd" then
            opts.init_options = {
              fallbackFlags = { "--std=c++17" },
            }
          end

          -- Custom config for Rust Analyzer
          if server_name == "rust_analyzer" then
            opts.settings = {
              ["rust-analyzer"] = {
                check = {
                  command = "clippy",
                },
                diagnostics = {
                  enable = true,
                },
              },
            }
          end

          -- 3. THE FIX: Use the new Neovim 0.11 API
          -- Define the config
          vim.lsp.config(server_name, opts)
          -- Enable the server
          vim.lsp.enable(server_name)
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- GLOBAL DIAGNOSTIC KEYMAPS
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Floating Error" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

      -- LSP ATTACH AUTOCMD
      -- This handles keymaps when the server actually connects to a buffer.
      -- This remains exactly the same as before.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = "Go to Declaration" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts, { desc = "Go to Definition" })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts, { desc = "Method Info Hover" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts, { desc = "Go to Implementation" })
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts, { desc = "Signature Help" })
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts, { desc = "Type Definition" })
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts, { desc = "Rename Variable" })
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts, { desc = "Code Actions Available" })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts, { desc = "Go to References" })
        end,
      })
    end,
  },
}
