vim.keymap.set("n", "<leader>ce", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #diagnostics > 0 then
		local message = diagnostics[1].message
		vim.fn.setreg("+", message)
		print("Copied diagnostic: " .. message)
	else
		print("No diagnostic at cursor")
	end
end, { noremap = true, silent = true })
-- go to errors in a file :/
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next) -- next err
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev) -- previous err

-- notify config
local ignore_patterns = {
  "gopls:",
  "InlayHint",
}
local old_notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
    for _, pattern in ipairs(ignore_patterns) do
      if msg:match(pattern) then
        return
      end
    end
  end
  old_notify(msg, level, opts)
end
