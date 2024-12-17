return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "javascript", "go", "html", "tsx", "typescript", "json" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}
