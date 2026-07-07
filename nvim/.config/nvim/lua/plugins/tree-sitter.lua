return {
	"nvim-treesitter/nvim-treesitter",
	-- branch = "main",
	build = ":TSUpdate",
	config = function()
		-- chỉ giữ phần parser management
		require("nvim-treesitter").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"go",
				"rust",
			},
			auto_install = true,
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
