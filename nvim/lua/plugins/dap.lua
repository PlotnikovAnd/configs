return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			-- == ВАРИАНТ С F-КЛАВИШАМИ (КАК В IDE) ==
			-- { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Continue" },
			-- { "<F10>",      function() require("dap").step_over() end,         desc = "Debug: Step Over" },
			-- { "<F11>",      function() require("dap").step_into() end,         desc = "Debug: Step Into" },
			-- { "<F12>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },
			-- -- F9 - стандарт для Breakpoint в большинстве IDE
			-- { "<F9>",       function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },

			-- == ВАРИАНТ С LEADER (MNEMONIC) ==
			-- d = Debug
			{ "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Breakpoint" },
			{ "<Leader>dc", function() require("dap").continue() end,          desc = "Debug: Continue" },
			{ "<Leader>do", function() require("dap").step_over() end,         desc = "Debug: Step Over" },
			{ "<Leader>di", function() require("dap").step_into() end,         desc = "Debug: Step Into" },

			-- Дополнительно: открыть интерфейс вручную, если закрыли
			{ "<Leader>du", function() require("dapui").toggle() end,          desc = "Debug: UI Toggle" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			require("mason-nvim-dap").setup({
				automatic_installation = true,
				ensure_installed = { "codelldb" },
				handlers = {},
			})

			-- Конфигурация для C++ (чтобы запрашивать путь к бинарнику)
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
				},
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
		end,
	},
}
