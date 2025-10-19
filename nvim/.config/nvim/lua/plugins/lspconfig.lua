return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({})
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- helper để setup gọn
      local function setup(server, opts)
        vim.lsp.config(server, opts or { capabilities = capabilities })
      end

      setup("ts_ls", { capabilities = capabilities })
      setup("pylsp", { capabilities = capabilities })
      setup("gopls", { capabilities = capabilities })
      setup("pbls", { capabilities = capabilities })
      setup("lua_ls", { capabilities = capabilities })
      setup("zls", { capabilities = capabilities })
      setup("sqlls", { capabilities = capabilities })

      setup("tailwindcss", {
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "clsx\\(([^)]*)\\)", "([^\\s]+)" },
                { "classnames\\(([^)]*)\\)", "([^\\s]+)" },
              },
            },
          },
        },
      })
      lspconfig.sqlls.setup({
        capabilities = capabilities,
      })
      lspconfig.c3.setup({
        capabilities = capabilities,
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP
          "gopls",
          "typescript-language-server",
          "lua-language-server",
          "tailwindcss-language-server",
          "sqls",
          "buf-language-server",

          -- Formatter
          "prettier",
          "stylua",
          "clang-format",

          -- Linter
          "eslint_d",
          "golangci-lint",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- wait 3s before auto install
      })
    end,
  },
}
