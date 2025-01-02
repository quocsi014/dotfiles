return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local custom_theme = require("lualine.themes.tokyonight")

		-- Đảm bảo rằng `c` tồn tại trong từng chế độ
		for _, mode in pairs({ "normal", "insert", "visual", "replace" }) do
			if custom_theme[mode] and custom_theme[mode].c then
				custom_theme[mode].c.bg = nil -- Làm nền trong suốt
			end
		end
    local os_icon = function()
			local uname = vim.loop.os_uname().sysname:lower()
			if uname:find("linux") then
				return " "
			elseif uname:find("darwin") then
				return ""
			elseif uname:find("windows") then
				return " "
			else
				return " "
			end
		end
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = custom_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "NvimTree", "packer" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", os_icon, "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "nvim-tree", "quickfix" },
		})
	end,
}
