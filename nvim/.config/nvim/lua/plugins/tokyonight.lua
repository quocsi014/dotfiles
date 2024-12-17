return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd("colorscheme tokyonight")  -- Đúng cú pháp để áp dụng theme
    end
}
