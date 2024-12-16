return {
    "folke/tokyonight.nvim",
    lazy = false,  -- Không cần thiết khi bạn không dùng Lazy loading cho plugin này
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd("colorscheme tokyonight")  -- Đúng cú pháp để áp dụng theme
    end
}