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
			transparent = true,
			styles = {
				sidebars = "transparent",
				-- "transparent" làm bg_float = NONE → hover/modal dễ trông như một màu, TS khó tách lớp.
				-- "dark" dùng bg_dark cho float (theo tokyonight.nvim/lua/tokyonight/colors/init.lua).
				floats = "dark",
			},
			--- https://github.com/folke/tokyonight.nvim — NormalFloat + @markup cho LSP hover / markdown
			on_highlights = function(hl, c)
				hl.NormalFloat = { fg = c.fg, bg = c.bg_float }
				hl.FloatBorder = { fg = c.border_highlight, bg = c.bg_float }
				hl.FloatTitle = { fg = c.border_highlight, bg = c.bg_float }
				-- Mặc định ["@markup"] = "@none" → gần như trùng Normal; tách nhẹ để khác heading/link/code
				hl["@markup"] = { fg = c.fg_dark }
			end,
		})
		vim.cmd("colorscheme tokyonight-storm")
	end,
}
