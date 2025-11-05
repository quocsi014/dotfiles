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
      -- auto_install = true,
      automatic_installation = false,
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Thêm vào trong config function của nvim-lspconfig
      vim.api.nvim_create_user_command("LspClients", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        print("Active LSP clients:")
        for _, client in ipairs(clients) do
          print(string.format("  - %s (id: %d)", client.name, client.id))
        end
      end, {})

      -- Danh sách servers
      local servers = {
        "ts_ls",
        "pylsp",
        "gopls",
        "pbls",
        "lua_ls",
        "zls",
        "sqlls",
        "rust_analyzer",
      }

      -- Setup từng server
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      -- Tailwind CSS setup riêng
      lspconfig.tailwindcss.setup({
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

      -- Keymaps cho LSP
      local keymap = vim.keymap.set
      keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      -- keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      -- keymap("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
      -- keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "Show References" })
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      -- keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- LSP servers
          "gopls",
          "typescript-language-server",
          "lua-language-server",
          "tailwindcss-language-server",
          "sqls",
          "buf-language-server",
          -- Formatters
          "prettier",
          "stylua",
          "clang-format",
          -- Linters
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
