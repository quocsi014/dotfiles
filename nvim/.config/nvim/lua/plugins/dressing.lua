return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "➤ ",
      win_options = {
        winblend = 0,
      },
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
      builtin = {
        mappings = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
          ["j"] = "MoveDown",
          ["k"] = "MoveUp",
        },
      },
    },
  },
}
