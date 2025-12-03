    
return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- В Neovim 0.11+ больше не нужно использовать lspconfig.util
			-- или вручную загружать конфиги. Все встроено.

			vim.lsp.set_log_level("info")

			-- 1. Список простых серверов, которые нужно просто включить
			local simple_servers = {
				"lua_ls",
				"rust_analyzer",
				"cmake",
				"bashls",
				"jsonls",
				"marksman",
				"gopls",
				"ruff"
			}

			for _, server in ipairs(simple_servers) do
				-- Эта функция сама найдет конфиг из плагина nvim-lspconfig
				vim.lsp.enable(server)
			end

			-- 2. Настройка clangd
			-- Сначала регистрируем ваши настройки (они сольются с дефолтными)
			vim.lsp.config("clangd", {
				cmd = { "clangd" },
				-- В Neovim 0.11 вместо root_dir + util можно использовать root_markers
				root_markers = { "compile_commands.json", "CMakeLists.txt" },
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
			-- Затем включаем сервер
			vim.lsp.enable("clangd")

			-- 3. Общие настройки привязок клавиш (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gh", function()
						-- 1. Формируем параметры: указываем URI текущего файла
						local params = { uri = vim.uri_from_bufnr(0) }
						
						-- 2. Отправляем запрос серверу
						vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
							if err then
								vim.notify("Error: " .. tostring(err), vim.log.levels.ERROR)
								return
							end
							
							if not result then
								vim.notify("Corresponding source/header file not found", vim.log.levels.INFO)
								return
							end
							
							-- 3. Открываем полученный файл
							vim.cmd.edit(vim.uri_to_fname(result))
						end)
					end, { buffer = ev.buf, desc = "Switch Source/Header (Clangd)" })
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

  
