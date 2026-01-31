return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "lm_studio",

		vendors = {
			lm_studio = {
				__inherited_from = "openai",
				api_key_name = "LM_STUDIO_API_KEY",
				endpoint = "http://127.0.0.1:1234/v1",
				model = "qwen2.5-coder-14b-instruct",

				extra_request_body = {
					temperature = 0.0,
					max_tokens = 8192,
				},
			},
		},

		-- [ERROR / DEPRECATED]: Этот блок вызывает ошибку предупреждения при запуске.
		-- Разработчик перенес конфигурацию провайдеров внутрь таблицы `vendors` или `providers`.
		-- Так как мы используем lm_studio, а не openai напрямую, этот блок здесь лишний и мусорный.
		-- РЕКОМЕНДАЦИЯ: Удалить этот блок полностью.
		-- openai = {
		--   temperature = 0,
		--   max_tokens = 8192,
		-- },

		behaviour = {
			auto_suggestions = false,
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
	},

	build = "make",

	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
	},

	init = function()
		vim.env.LM_STUDIO_API_KEY = "sk-lm-studio-key"
	end,
}
