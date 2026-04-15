return {
	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason + lspconfig bridge
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"ts_ls",
					"lua_ls",
					"pylsp",
					"rust_analyzer",
					"zls",
					"sqlls",
					"tailwindcss",
				},
				handlers = {
					-- default handler
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- custom tailwind
					["tailwindcss"] = function()
						require("lspconfig").tailwindcss.setup({
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
						})
					end,
				},
			})
		end,
	},

	-- LSP keymaps + commands
	{
		"neovim/nvim-lspconfig",
		config = function()
			local keymap = vim.keymap.set

			keymap("n", "K", vim.lsp.buf.hover)
			keymap("n", "gd", vim.lsp.buf.definition)
			keymap("n", "gr", vim.lsp.buf.references)
			keymap("n", "<leader>rn", vim.lsp.buf.rename)
			keymap("n", "<leader>ca", vim.lsp.buf.code_action)

			-- Restart LSP command
			vim.api.nvim_create_user_command("LspRestart", function()
				local clients = vim.lsp.get_active_clients()
				for _, client in pairs(clients) do
					vim.lsp.stop_client(client.id)
				end
				vim.cmd("edit")
			end, {})

			-- Show active clients
			vim.api.nvim_create_user_command("LspClients", function()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				print("Active LSP clients:")
				for _, client in ipairs(clients) do
					print(client.name)
				end
			end, {})
		end,
	},
}
