return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Или blink.cmp, если перешли на него
		config = function()
			-- В Neovim 0.11+ больше не нужно использовать lspconfig.util
			-- или вручную загружать конфиги. Все встроено.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Настройка clangd
			-- Сначала регистрируем ваши настройки (они сольются с дефолтными)
			vim.lsp.config("clangd", {
				-- В Neovim 0.11 вместо root_dir + util можно использовать root_markers
				root_markers = {
					"compile_commands.json",
					"CMakeLists.txt",
					"meson.build",
					"meson_options.txt",
					".git",
				},
				capabilities = vim.tbl_deep_extend("force", capabilities, {
					offsetEncoding = { "utf-16" },
				}),
				cmd = {
					"clangd",
					"--background-index", -- Индексирует проект в фоне. Без этого не будут работать "Go to definition" и поиск ссылок во всем проекте.
					"--clang-tidy", -- Включает встроенный линтер (показывает ошибки статического анализа и стилистики прямо в редакторе).
					"--header-insertion=iwyu", -- Расшифровывается как "Include What You Use". Если вы используете std::string, а заголовок <string> не подключен, clangd сам добавит #include <string> при автодополнении.
					"--completion-style=detailed", -- Показывает больше инфы в меню автодополнения (типы, сигнатуры).
					"--function-arg-placeholders", -- При автодополнении функции добавляет "заглушки" для аргументов (snippet placeholders), по которым можно прыгать через Tab.
					"--fallback-style=llvm", -- Стиль форматирования, если нет файла .clang-format.
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
			-- Затем включаем сервер
			vim.lsp.enable("clangd")

			-- Список простых серверов, которые нужно просто включить
			local simple_servers = {
				"lua_ls",
				"rust_analyzer",
				"cmake",
				"bashls",
				"jsonls",
				"marksman",
				"gopls",
				"ruff",
			}

			for _, server in ipairs(simple_servers) do
				-- Эта функция сама найдет конфиг из плагина nvim-lspconfig
				vim.lsp.enable(server)
			end

			-- 3. Общие настройки привязок клавиш (LspAttach)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gh", function()
						-- Формируем параметры: указываем URI текущего файла
						local params = { uri = vim.uri_from_bufnr(0) }

						-- Отправляем запрос серверу
						vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
							if err then
								vim.notify("Error: " .. tostring(err), vim.log.levels.ERROR)
								return
							end

							if not result then
								vim.notify("Corresponding source/header file not found", vim.log.levels.INFO)
								return
							end

							-- Открываем полученный файл
							vim.cmd.edit(vim.uri_to_fname(result))
						end)
					end, { buffer = ev.buf, desc = "Switch Source/Header (Clangd)" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set(
						{ "n", "i" },
						"<C-s>",
						vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = "Show signature help" }
					)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
