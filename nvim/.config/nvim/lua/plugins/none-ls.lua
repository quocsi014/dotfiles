return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			timeout = 300000, -- null-ls timeout
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.formatting.clang_format.with({
					command = "/usr/bin/clang-format",
					filetypes = { "c", "cpp", "objc", "proto" },
				}),
			},
		})
		
		-- Set LSP client timeout khi format
		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				timeout_ms = 300000, -- 300 seconds
			})
		end, {})
	end,
}
