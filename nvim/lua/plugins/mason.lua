return {
	-- 1. Сам Mason (Менеджер пакетов)
	{
		'williamboman/mason.nvim', -- Обратите внимание: оф. репозиторий williamboman, а не mason-org
		cmd = "Mason",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},

	-- 2. Автоустановка LSP серверов (clangd, lua_ls и т.д.)
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require('mason-lspconfig').setup {
				ensure_installed = {
					"bashls",
					"clangd",
					"cmake",
					"gopls",
					"jsonls",
					"lua_ls",
					"marksman",
					"ruff",
					"rust_analyzer",
				}
			}
		end
	},

	-- 3. Автоустановка Форматтеров (Stylua, Prettier) и Линтеров
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require('mason-tool-installer').setup {
				ensure_installed = {
					-- Сюда пишем инструменты, которые НЕ являются LSP
					"stylua", -- Форматтер для Lua
					"prettier", -- Форматтер для JS/TS/HTML/CSS/JSON

					-- Можно добавить еще:
					-- "codelldb", -- Дебаггер для C++
					-- "eslint_d", -- Линтер для JS
				},
				auto_update = true,
				run_on_start = true,
			}
		end
	},
}
