return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icons
  config = function()
    local fzf = require("fzf-lua")

    -- Key bindings for fzf-lua
    fzf.setup({
      keymap = {
        builtin = {
          ["<C-t>"] = "tabedit",
          ["<C-x>"] = "split",
          ["<C-v>"] = "vsplit",
        },
      },
      winopts = {
        width = 0.8,
        height = 0.5,
        border = "rounded",
        hl = {
          border = "Comment",
        },
      },
      preview = {
        layout = "vertical", -- Options: horizontal, vertical, flex
        vertical = "up:50%", -- Top half for preview
      },
      git = {
        commits = {
          cmd = "git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr'",
        },
      },
    })

    -- Key mappings
    vim.keymap.set("n", "<C-p>", function()
      fzf.files({
        prompt = "Files❯ ",
        previewer = "builtin", -- Enable file preview
        fzf_opts = {
          ["--layout"] = "reverse",
          ["--info"] = "inline",
        },
      })
    end, { desc = "Search files" })

    vim.keymap.set("n", "<M-a>", function()
      fzf.live_grep({
        prompt = "Rg❯ ",
        cmd = "rg --column --line-number --color=always --smart-case",
        fzf_opts = {
          ["--layout"] = "reverse",
          ["--info"] = "inline",
        },
      })
    end, { desc = "Live grep" })

    -- Ignore specific files and directories in search
    vim.env.FZF_DEFAULT_COMMAND = [[find . \( -name __pycache__ -o -name .git -o -name .vagrant \) -prune -o -print]]
  end,
}
