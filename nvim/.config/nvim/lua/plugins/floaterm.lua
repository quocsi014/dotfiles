return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      border = "rounded",
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
      blend = 0,
    })
    
    -- Transparent background
    vim.api.nvim_set_hl(0, "FTermNormal", {
      bg = "NONE",  -- Transparent
      fg = "#c0caf5",
    })
    
    vim.api.nvim_set_hl(0, "FTermBorder", {
      fg = "#7aa2f7",
      bg = "NONE",  -- Transparent
    })
    
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "FTerm",
      callback = function()
        vim.opt_local.winhl = "Normal:FTermNormal,FloatBorder:FTermBorder"
      end,
    })
    
    vim.keymap.set("n", "<M-t>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle Terminal" })
    vim.keymap.set("t", "<M-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle Terminal" })
  end,
}
