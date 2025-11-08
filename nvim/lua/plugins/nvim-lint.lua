return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			bash        = { 'bash' },
			clang_tidy  = { 'clangtidy' },
			python      = { 'ruff' },
			ansible     = { 'ansible_lint' },
			yamllint    = { 'yamllint' },
			systemdlint = { 'systemdlint' },
			cmakelint   = { 'cmakelint' }
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end
}
