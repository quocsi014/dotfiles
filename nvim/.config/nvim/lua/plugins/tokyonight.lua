return {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {},
    config = function()
        vim.cmd("colorscheme tokyonight-storm")  -- Đúng cú pháp để áp dụng theme
    end
}
