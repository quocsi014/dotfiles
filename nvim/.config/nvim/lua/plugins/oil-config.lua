return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
    },
    view_options = {
      show_hidden = true,  -- Hiện file ẩn
    },
    
    -- Chỉ confirm khi xóa
    delete_to_trash = false,              -- Xóa hẳn (sẽ hỏi Y/N)
    skip_confirm_for_simple_edits = true, -- Không confirm rename/move
    
  },
}
