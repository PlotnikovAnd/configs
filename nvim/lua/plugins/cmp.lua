return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					-- ПРОКРУТКА ДОКУМЕНТАЦИИ
					-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- ВЫЗОВ МЕНЮ ВРУЧНУЮ
					["<C-Space>"] = cmp.mapping.complete(),

					-- ЗАКРЫТЬ МЕНЮ
					["<C-e>"] = cmp.mapping.abort(),

					-- ПОДТВЕРДИТЬ ВЫБОР (Enter)
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- == НАВИГАЦИЯ ПО МЕНЮ (Вместо Tab) ==
					-- Используем стандартные Vim-хоткеи или удобные C-j/C-k
					-- ["<C-n>"] = cmp.mapping.select_next_item(), -- Вниз
					-- ["<C-p>"] = cmp.mapping.select_prev_item(), -- Вверх

					-- Альтернатива (если вам удобнее j/k как в навигации по файлу)
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),

					-- == ПРЫЖКИ ВНУТРИ СНИППЕТОВ ==
					-- Tab будет работать как "прыжок" только ЕСЛИ вы внутри активного сниппета.
					-- Во всех остальных случаях сработает ваш fallback (переключение табов).
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback() -- ВОТ ЗДЕСЬ сработает ваше переключение табов
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
