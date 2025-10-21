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

      -- Setup các LSP servers với vim.lsp.config (Neovim 0.11+)
      local servers = {
        "ts_ls",
        "pylsp",
        "gopls",
        "pbls",
        "lua_ls",
        "zls",
        "sqlls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- Setup Tailwind CSS với config đặc biệt
      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "clsx\\(([^)]*)\\)",       "([^\\s]+)" },
                { "classnames\\(([^)]*)\\)", "([^\\s]+)" },
              },
            },
          },
        },
      })

      -- Enable LSP servers
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end
      vim.lsp.enable("tailwindcss")

      -- Keymaps cho LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show References" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
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
        start_delay = 3000,
      })
    end,
  },
}
