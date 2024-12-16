return {
    {
        "vim-airline/vim-airline", lazy = false,  -- Không cần thiết khi bạn không dùng Lazy loading cho plugin này
        priority = 1000,
        opts = {},
        config = function()
            -- Enable Powerline fonts
            vim.g.airline_powerline_fonts = 1

            -- Set theme
            vim.g.airline_theme = 'violet'

            -- Enable Tabline extension
            vim.g.airline_extensions_tabline_enabled = 1
            vim.g.airline_extensions_tabline_left_sep = ' '
            vim.g.airline_extensions_tabline_left_alt_sep = '|'
            vim.g.airline_extensions_tabline_formatter = 'default'
            vim.g.airline_extensions_tabline_fnamemod = ':t'

            -- Disable whitespace warning extension
            vim.g.airline_extensions_whitespace_enabled = 0

            -- Empty error section
            vim.g.airline_section_error = ''
        end
    },
    {
        "vim-airline/vim-airline-themes",
        lazy = false,  -- Không cần thiết khi bạn không dùng Lazy loading cho plugin này
        priority = 1000,
        opts = {},
        config = function()
            vim.g.airline_theme = 'violet'
        end
    }
}
