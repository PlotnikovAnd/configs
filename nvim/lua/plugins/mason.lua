return {
	{
		'mason-org/mason.nvim',
		opts = {},
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require('mason-lspconfig').setup {
				ensure_installed = {
					"bashls",
					"black",
					"clangd",
					"cmake",
					"flake8",
					"gopls",
					"jsonls",
					"lua_ls",
					"marksman",
					"ruff",
					"rust_analyzer",
					"xmlformatter"
				}
			}
		end
	},
}
