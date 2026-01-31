return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references",
		},
		-- А) Открыть обычный Quickfix (системный) - теперь маленькая 'q'
		{
			"<leader>xq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},

		-- Б) Открыть то, что пришло из TELESCOPE (ваше Alt-q)
		-- Добавляем этот маппинг, чтобы возвращать результаты поиска
		-- {
		-- 	"<leader>xt", -- t = Telescope
		-- 	"<cmd>Trouble telescope toggle<cr>",
		-- 	desc = "Telescope Results (Trouble)",
		-- },
	},
}
