return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-space>"] = actions.toggle_selection + actions.move_selection_worse, -- Thêm file vào danh sách chọn
						["<C-k>"] = "move_selection_previous", -- Di chuyển lên
						["<C-j>"] = "move_selection_next",
						["<CR>"] = function(prompt_bufnr)
							local picker = action_state.get_current_picker(prompt_bufnr)
							local multi_selections = picker:get_multi_selection()

							if #multi_selections > 0 then
								for _, entry in ipairs(multi_selections) do
									vim.cmd("badd " .. entry.path) -- Thêm file vào buffer list
								end
								actions.close(prompt_bufnr)
							else
								actions.select_default(prompt_bufnr) -- Nếu không chọn gì, mở file hiện tại
							end
						end,
					},
				},
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true, -- Hiển thị các file ẩn
			})
		end, {})
	end,
}
