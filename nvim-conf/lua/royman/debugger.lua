return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{ "rcarriga/nvim-dap-ui" },
		{ "nvim-neotest/nvim-nio" },
	},
	config = function()
		vim.keymap.set("n", "_u", ":lua require'dapui'.toggle()<CR>", { desc = "DEBUGGER: toggle UI" })
		vim.keymap.set("n", "_c", ":lua require'dap'.continue()<CR>", { desc = "DEBUGGER: continue / start" })
		vim.keymap.set("n", "_s", ":lua require'dap'.step_over()<CR>", { desc = "DEBUGGER: step over" })
		vim.keymap.set("n", "_i", ":lua require'dap'.step_into()<CR>", { desc = "DEBUGGER: step into" })
		vim.keymap.set("n", "_o", ":lua require'dap'.step_out()<CR>", { desc = "DEBUGGER: step out" })
		vim.keymap.set("n", "_b", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "DEBUGGER: toggle breakpoint" })
		vim.keymap.set(
			"n",
			"_B",
			":lua require'dap'.toggle_breakpoint('i == 1')",
			{ desc = "DEBUGGER: toggle conditional breakpoint" }
		)
		vim.keymap.set("x", "<leader>cm", ":Refactor extract ", { desc = "extract method" })
		vim.keymap.set("x", "<leader>cv", ":Refactor extract_var ", { desc = "extract variable" })

		local dap = require("dap")
		require("dapui").setup()
		function pythonPath()
			local cwd = vim.loop.cwd()
			-- Prüfe, ob ein virtueller Python-Interpreter vorhanden ist
			if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				-- Standard-Python-Interpreter, wenn kein virtuelles Environment gefunden wird
				return "/usr/bin/python3"
			end
		end
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = pythonPath(),
			},
			{
				-- requires 'pip install debugpy'
				type = "python",
				request = "launch",
				name = "DAP Django",
				program = vim.loop.cwd() .. "/manage.py",
				args = { "runserver", "--noreload" },
				justMyCode = true,
				django = true,
				console = "integratedTerminal",
			},
			{
				type = "python",
				request = "attach",
				name = "Attach remote",
				connect = function()
					return {
						host = "127.0.0.1",
						port = 5678,
					}
				end,
			},
		}
		dap.adapters.python = {
			type = "executable",
			command = pythonPath(),
			args = { "-m", "debugpy.adapter" },
		}
	end,
}
