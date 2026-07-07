return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = false,
				automatic_enable = false,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local old_deprecate = vim.deprecate
			vim.deprecate = function() end

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.workspace = vim.tbl_deep_extend("force", capabilities.workspace or {}, {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
					relativePatternSupport = true,
				},
			})

			require("lsp-sync").setup()

			vim.api.nvim_create_user_command("LspClients", function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				print("Active LSP clients:")
				for _, client in ipairs(clients) do
					print(string.format("  - %s (id: %d)", client.name, client.id))
				end
			end, {})

			-- Danh sách servers
			local servers = {
				"pylsp",
				"ts_ls",
				"gopls",
				"lua_ls",
				"zls",
				"postgres_lsp",
				"rust_analyzer",
				"html",
			}

			-- Setup từng server
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end

			-- Tailwind CSS setup riêng
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "clsx\\(([^)]*)\\)", "([^\\s]+)" },
								{ "classnames\\(([^)]*)\\)", "([^\\s]+)" },
							},
						},
					},
				},
			})

			-- Hover window: giới hạn chiều ngang + bo góc + thêm padding.
			local hover_opts = {
				max_width = 90,
				max_height = 30,
				border = "rounded",
				focusable = true,
				winhighlight = "FloatBorder:NormalFloat",
			}
			vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
				if err or not (result and result.contents) then
					return
				end

				local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
				lines = vim.lsp.util.trim_empty_lines(lines)
				if vim.tbl_isempty(lines) then
					return
				end

				local pad_x = "  "
				local padded = { "" } -- top padding
				for _, line in ipairs(lines) do
					table.insert(padded, pad_x .. line .. pad_x) -- left/right padding
				end
				table.insert(padded, "") -- bottom padding

				local final_opts = vim.tbl_extend("force", hover_opts, config or {})
				return vim.lsp.util.open_floating_preview(padded, "markdown", final_opts)
			end

			-- Keymaps cho LSP
			local keymap = vim.keymap.set
			keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
			-- keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			-- keymap("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
			-- keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show References" })
			keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			-- keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

			vim.deprecate = old_deprecate
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP servers
					"gopls",
					"typescript-language-server",
					"lua-language-server",
					"tailwindcss-language-server",
					"sqls",
					"buf-language-server",
					-- Formatters
					"prettier",
					"stylua",
					"clang-format",
					-- Linters
					"eslint_d",
					"golangci-lint",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},
}
