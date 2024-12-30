  return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons dependency
  config = function()
    -- Move to previous/next
    vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { silent = true })
    vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { silent = true })

    -- Re-order to previous/next
    vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { silent = true })
    vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { silent = true })

    -- Goto buffer in position...
    for i = 1, 9 do
      vim.keymap.set("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", { silent = true })
    end
    vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { silent = true })

    -- Buffer pick
    vim.keymap.set("n", "<A-p>", "<Cmd>BufferPick<CR>", { silent = true })

    -- Close buffer
    vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { silent = true })

    -- Restore buffer
    vim.keymap.set("n", "<A-s-c>", "<Cmd>BufferRestore<CR>", { silent = true })

    -- Sort automatically by...
    vim.keymap.set("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { silent = true })
    vim.keymap.set("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", { silent = true })
    vim.keymap.set("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", { silent = true })
    vim.keymap.set("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", { silent = true })
    vim.keymap.set("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { silent = true })

    -- Enable barbar (enabled by default, but you can toggle it)
    vim.cmd("BarbarEnable")
  end,
}

