return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- Источники для автодополнения
		"hrsh7th/cmp-nvim-lsp", -- LSP источник
		"hrsh7th/cmp-buffer", -- слова из текущего буфера
		"hrsh7th/cmp-path", -- пути к файлам

		-- Движок сниппетов (ОБЯЗАТЕЛЬНО для работы Tab)
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			-- 1. Указываем, как обрабатывать сниппеты
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- 2. Настройка клавиш (Mappings)
			mapping = cmp.mapping.preset.insert({
				-- Прокрутка документации (если есть)
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),

				-- Вызов меню автодополнения вручную (Ctrl + Space)
				['<C-Space>'] = cmp.mapping.complete(),

				-- Отмена (Esc или Ctrl+e)
				['<C-e>'] = cmp.mapping.abort(),

				-- ENTER: Подтверждение выбора
				['<CR>'] = cmp.mapping.confirm({
					select = true, -- Если true, то Enter выберет первый пункт, даже если вы его не выделили явно
					behavior = cmp.ConfirmBehavior.Replace,
				}),

				-- TAB: Супер-Таб (циклическое переключение)
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- Если меню открыто — идем вниз
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						-- Если мы внутри сниппета — прыгаем к следующей позиции ($1 -> $2)
						luasnip.expand_or_jump()
					else
						-- Иначе — просто печатаем Tab
						fallback()
					end
				end, { "i", "s" }),

				-- SHIFT + TAB: Движение назад
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						-- Если меню открыто — идем вверх
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						-- Если внутри сниппета — прыгаем назад
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- 3. Источники (порядок важен — сверху приоритет выше)
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- данные от LSP (clangd, pyright и т.д.)
				{ name = "luasnip" }, -- сниппеты
				{ name = "path" }, -- пути к файлам
			}, {
				{ name = "buffer" }, -- слова из открытого файла
			}),

			-- Опционально: Добавляем рамочки к окну подсказок
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})
	end,
}
