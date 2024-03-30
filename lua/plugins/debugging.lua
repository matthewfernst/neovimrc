return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("dapui").setup()
		require("dap-python").setup("/Users/matthewernst/miniconda3/envs/mlx-env/bin/python")
		local dap, dapui = require("dap"), require("dapui")

		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb",
			name = "lldb",
		}

		dap.configurations.cpp = {
			-- Example
			{
				name = "graph_test",
				type = "lldb",
				request = "launch",
				program = "graph_test",
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
		}

		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					elseif vim.fn.executable("/Users/matthewernst/miniconda3/envs/homl3/bin/python") == 1 then
						return "/Users/matthewernst/miniconda3/envs/homl3/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "mnsit test",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

				program = "${workspaceFolder}/mnist.py", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					elseif vim.fn.executable("/Users/matthewernst/miniconda3/envs/mlx-env/bin/python") == 1 then
						return "/Users/matthewernst/miniconda3/envs/mlx-env/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
		vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
		vim.keymap.set("n", "<Leader>dn", ":DapStepOver<CR>")
		vim.keymap.set("n", "<Leader>do", ":DapStepOut<CR>")
		vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>")
	end,
}
