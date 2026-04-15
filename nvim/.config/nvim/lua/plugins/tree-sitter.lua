return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      -- Fix lỗi render-markdown: stale node gọi :range() bị nil
      local orig = vim.treesitter.get_node_text
      vim.treesitter.get_node_text = function(node, source, opts)
        if node == nil or type(node.range) ~= "function" then
          return ""
        end
        return orig(node, source, opts)
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "go",
          "markdown",
          "markdown_inline",
          "javascript",
          "typescript",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
