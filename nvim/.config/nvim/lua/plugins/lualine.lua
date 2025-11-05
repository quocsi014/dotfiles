-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     local custom_theme = require("lualine.themes.tokyonight")
--
--     -- Đảm bảo rằng `c` tồn tại trong từng chế độ
--     for _, mode in pairs({ "normal", "insert", "visual", "replace" }) do
--       if custom_theme[mode] and custom_theme[mode].c then
--         custom_theme[mode].c.bg = nil -- Làm nền trong suốt
--       end
--     end
--     local os_icon = function()
--       local uname = vim.loop.os_uname().sysname:lower()
--       if uname:find("linux") then
--         return " "
--       elseif uname:find("darwin") then
--         return ""
--       elseif uname:find("windows") then
--         return " "
--       else
--         return " "
--       end
--     end
--     require("lualine").setup({
--       options = {
--         icons_enabled = true,
--         theme = custom_theme,
--         component_separators = { left = "", right = "" },
--         section_separators = { left = "", right = "" },
--         disabled_filetypes = { "NvimTree", "packer" },
--         always_divide_middle = true,
--       },
--       sections = {
--         lualine_a = { "mode" },
--         lualine_b = { "branch", "diff", "diagnostics" },
--         lualine_c = { "filename" },
--         lualine_x = { "encoding", os_icon, "filetype" },
--         lualine_y = { "progress" },
--         lualine_z = { "location" },
--       },
--       inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = { "filename" },
--         lualine_x = { "location" },
--         lualine_y = {},
--         lualine_z = {},
--       },
--       tabline = {},
--       extensions = { "nvim-tree", "quickfix" },
--     })
--   end,
-- }
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom_theme = require("lualine.themes.tokyonight")

    -- Làm background trong suốt và text sáng hơn
    for _, mode in pairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      if custom_theme[mode] then
        if custom_theme[mode].a then
          custom_theme[mode].a.bg = "NONE"
          custom_theme[mode].a.fg = "#ffffff"
          custom_theme[mode].a.gui = "bold"
        end
        if custom_theme[mode].b then
          custom_theme[mode].b.bg = "NONE"
          custom_theme[mode].b.fg = "#c0caf5"
        end
        if custom_theme[mode].c then
          custom_theme[mode].c.bg = "NONE"
          custom_theme[mode].c.fg = "#a9b1d6"
        end
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
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "NvimTree", "packer" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          { os_icon, color = { fg = "#7aa2f7" } }, -- ← Thêm màu cho icon
          "filetype",
        },
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

    -- Giữ cho statusline trong suốt dù tokyonight có đổi màu
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "tokyonight*",
      callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
      end,
    })

    -- Chạy luôn khi start nvim
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

  end,
}
