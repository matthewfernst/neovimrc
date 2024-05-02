return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add File from Harpoon" })

		vim.keymap.set("n", "<leader>x", function()
			harpoon:list():remove()
		end, { desc = "Remove File from Harpoon" })

		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon Menu" })

		vim.keymap.set("n", "<C-s>", function()
			local curline = vim.api.nvim_get_current_line()
			local working_directory = vim.fn.getcwd() .. "/"
			vim.cmd("vs")
			vim.cmd("e " .. working_directory .. curline)
		end, { buffer = true, noremap = true, silent = true })

		vim.keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(_, map)
						map({ "i", "n" }, "<C-d>", function(prompt_bufnr)
							local action_state = require("telescope.actions.state")
							local current_picker = action_state.get_current_picker(prompt_bufnr)

							current_picker:delete_selection(function(selection)
								require("harpoon"):list():remove_at(selection.index)
							end)
						end, { desc = "Remove from harpoon list" })
						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<C-e>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon window" })
	end,
}
