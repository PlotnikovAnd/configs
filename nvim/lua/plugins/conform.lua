return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Загружать плагин перед сохранением файла
		cmd = { "ConformInfo" }, -- И доступ к команде информации
		opts = {
			-- Настройка форматтеров под конкретные языки
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" }, -- Сначала отсортирует импорты, потом отформатирует код

				-- Для Rust обычно используется LSP (rust-analyzer), но можно и rustfmt явно
				rust = { "rustfmt" },

				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },

				xml = { "xmlformatter" },

				-- Для C++ и C оставляем пустым, чтобы сработал lsp_fallback (clangd)
				cpp = {},
				c = {},
			},

			-- Настройка форматирования при сохранении
			format_on_save = {
				timeout_ms = 500, -- Если форматирование идет дольше 0.5сек, не ждать

				-- Самая важная настройка:
				-- Если для языка не найден форматтер в списке выше (например для cpp),
				-- то использовать LSP (clangd)
				lsp_format = "fallback",
			},
		},
	},
}
