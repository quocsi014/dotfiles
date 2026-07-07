local M = {}

local augroup = vim.api.nvim_create_augroup("LspSync", { clear = true })

local function valid_buf(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_is_valid(bufnr)
		and vim.api.nvim_buf_is_loaded(bufnr)
		and vim.bo[bufnr].buftype == ""
		and vim.api.nvim_buf_get_name(bufnr) ~= ""
end

--- Detach LSP, reload buffer from disk, re-attach so server gets fresh didOpen.
function M.sync_buf(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if not valid_buf(bufnr) then
		return
	end

	local path = vim.api.nvim_buf_get_name(bufnr)
	local client_ids = vim.tbl_map(function(c)
		return c.id
	end, vim.lsp.get_clients({ bufnr = bufnr }))

	for _, id in ipairs(client_ids) do
		vim.lsp.buf_detach_client(bufnr, id)
	end

	if vim.fn.filereadable(path) == 1 then
		local view = vim.fn.winsaveview()
		vim.bo[bufnr].modified = false
		vim.api.nvim_buf_call(bufnr, function()
			vim.cmd("silent! keepjumps edit!")
		end)
		vim.fn.winrestview(view)
	end

	vim.defer_fn(function()
		for _, id in ipairs(client_ids) do
			if vim.lsp.get_client_by_id(id) then
				vim.lsp.buf_attach_client(bufnr, id)
			end
		end
		if #vim.lsp.get_clients({ bufnr = bufnr }) == 0 then
			vim.api.nvim_buf_call(bufnr, function()
				vim.cmd("doautocmd FileType")
			end)
		end
	end, 100)
end

--- Stop LSP server processes for the buffer, reload from disk, re-enable.
function M.restart_buf(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if not valid_buf(bufnr) then
		return
	end

	local path = vim.api.nvim_buf_get_name(bufnr)
	local server_names = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		server_names[client.name] = true
		vim.lsp.stop_client(client.id, true)
	end

	if vim.fn.filereadable(path) == 1 then
		vim.bo[bufnr].modified = false
		vim.api.nvim_buf_call(bufnr, function()
			vim.cmd("silent! keepjumps edit!")
		end)
	end

	vim.defer_fn(function()
		for name, _ in pairs(server_names) do
			pcall(vim.lsp.enable, name, true)
		end
		vim.api.nvim_buf_call(bufnr, function()
			vim.cmd("doautocmd FileType")
		end)
		vim.notify("LSP restarted", vim.log.levels.INFO)
	end, 500)
end

function M.setup()
	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		group = augroup,
		callback = function()
			if vim.fn.getcmdwintype() ~= "" then
				return
			end
			vim.cmd("checktime")
		end,
	})

	vim.api.nvim_create_autocmd("FileChangedShellPost", {
		group = augroup,
		callback = function(args)
			M.sync_buf(args.buf)
			vim.notify("File reloaded from disk, LSP synced", vim.log.levels.INFO)
		end,
	})

	vim.api.nvim_create_user_command("LspSync", function()
		M.sync_buf()
		vim.notify("LSP synced with buffer", vim.log.levels.INFO)
	end, { desc = "Reload file from disk and sync LSP" })

	vim.api.nvim_create_user_command("LspRestart", function()
		M.restart_buf()
	end, { desc = "Restart LSP servers for current buffer" })

	vim.keymap.set("n", "<leader>lr", function()
		M.sync_buf()
		vim.notify("LSP synced with buffer", vim.log.levels.INFO)
	end, { desc = "Reload file & sync LSP" })
end

return M
