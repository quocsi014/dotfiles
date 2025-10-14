return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- icon đẹp cho heading / checkbox
		},
		ft = { "markdown", "rmd", "org" },
		opts = {
			-- Loại file được render
			file_types = { "markdown", "rmd", "org" },

			-- Cấu hình heading
			-- heading = {
			--   enabled = true,
			--   sign = true,
			-- },

			-- Checkbox (todo list)
			checkbox = {
				enabled = true,
				unchecked = "󰄱 ",
				checked = "󰄵 ",
				partial = "󰥔 ",
			},

			-- Table hiển thị gọn hơn
			table = {
				enabled = true,
				style = "full", -- full | compact
			},

			-- Code block format
			code = {
				enabled = true,
				border = "rounded",
				width = "block",
			},

			-- Quote format
			quote = {
				enabled = true,
				icon = "󰝗 ",
			},
		},

		config = function(_, opts)
			require("render-markdown").setup(opts)

			require("render-markdown").setup({
				checkbox = {
					enabled = true,
					render_modes = false,
					bullet = false,
					right_pad = 1,
					unchecked = {
						icon = "󰄱 ",
						highlight = "RenderMarkdownUnchecked",
						scope_highlight = nil,
					},
					checked = {
						icon = "󰱒 ",
						highlight = "RenderMarkdownChecked",
						scope_highlight = nil,
					},
					custom = {
						todo = {
							raw = "[-]",
							rendered = "󰥔 ",
							highlight = "RenderMarkdownTodo",
							scope_highlight = nil,
						},
					},
				},
			})
			-- Tự bật khi mở markdown
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					require("render-markdown").enable()
				end,
			})

			-- Tắt khi rời buffer markdown (optional)
			vim.api.nvim_create_autocmd("BufLeave", {
				pattern = "*.md",
				callback = function()
					require("render-markdown").disable()
				end,
			})

			-- Keymap bật/tắt thủ công
			vim.keymap.set("n", "<leader>mr", function()
				require("render-markdown").toggle()
			end, { desc = "Toggle Markdown Render" })
		end,
	},
}
