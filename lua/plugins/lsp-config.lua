return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",
					"cmake",
					"dockerls",
					"jsonls",
					"tsserver",
					"marksman",
					"pyright",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.clangd.setup({})
			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
						diagnostics = {
							enable = true,
						},
					},
				},
			})

			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open Floating Error" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
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
					-- vim.keymap.set("n", "<space>f", function()
					-- 	vim.lsp.buf.format({ async = true })
					-- end, opts)
				end,
			})
		end,
	},
}
