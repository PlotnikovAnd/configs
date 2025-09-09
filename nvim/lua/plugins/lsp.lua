return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')

			vim.lsp.set_log_level("debug")
			lspconfig.lua_ls.setup {}
			lspconfig.rust_analyzer.setup {}
			lspconfig.cmake.setup {}
			lspconfig.bashls.setup {}
			lspconfig.jsonls.setup {}
			lspconfig.marksman.setup {}
			lspconfig.clangd.setup {
				cmd = {
					"clangd"
				},
				root_dir = require 'lspconfig.util'.root_pattern("compile_commands.json", "CMakeLists.txt"),
				on_attach = function(client, bufnr)
					-- Отключаем semanticTokens, если не используются
					client.server_capabilities.semanticTokensProvider = nil

					-- Здесь остальное содержимое из "LspAttach"
				end,

			}
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = "Show signature help" })
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end
	}
}
