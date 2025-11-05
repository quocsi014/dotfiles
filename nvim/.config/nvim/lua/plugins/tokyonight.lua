-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     opts = {},
--     config = function()
--         vim.cmd("colorscheme tokyonight-storm")  -- Đúng cú pháp để áp dụng theme
--     end
-- }

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			transparent = true, -- Enable transparent background
			styles = {
				sidebars = "transparent", -- Sidebar trong suốt
				floats = "transparent", -- Float window trong suốt
			},
		})
		vim.cmd("colorscheme tokyonight-storm")
	end,
}
