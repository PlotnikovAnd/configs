return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build =
			'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
		},
		"folke/trouble.nvim",
	},
	config = function()
		local telescope = require('telescope')
		local trouble = require("trouble.sources.telescope")

		telescope.setup {
			defaults = {
				mappings = {
					i = { -- В режиме вставки (когда вы пишете поиск)
						-- Назначаем Alt-q на открытие Trouble вместо стандартного QF
						["<M-q>"] = trouble.open,

						-- Можно добавить и Ctrl-t (традиционный для Trouble)
						["<C-t>"] = trouble.open,
					},
					n = { -- В нормальном режиме (если нажали Esc внутри телескопа)
						["<M-q>"] = trouble.open,
						["<C-t>"] = trouble.open,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,    -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "ignore_case", -- or "smart_case" or "respect_case"
				}
			}
		}
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Find words (Grep)" })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help" })
		require('telescope').load_extension('fzf')
	end
}
