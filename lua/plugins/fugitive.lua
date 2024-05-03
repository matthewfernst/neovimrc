return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

		local theprimeagen_fugitive = vim.api.nvim_create_augroup("theprimeagen_fugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("bufwinenter", {
			group = theprimeagen_fugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>gs", function()
					vim.cmd.Git("push")
				end, opts, { desc = "git push" })

				-- rebase always
				vim.keymap.set("n", "<leader>gu", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, opts, { desc = "git pull --rebase" })

				-- NOTE: It allows me to easily set the branch i am pushing and any tracking
				-- needed if i did not set the branch up correctly
				vim.keymap.set("n", "<leader>go", ":Git push -u origin ", opts, { desc = "git push origin" })
				vim.keymap.set("n", "<leader>gm", function()
					vim.cmd.Git("commit")
				end, { desc = "git commit" })
				vim.keymap.set("n", "<leader>ga", function()
					vim.cmd.Git("commit --amend")
				end, { desc = "git commit --amend" })
			end,
		})
	end,
}
