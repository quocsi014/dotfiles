local function pluralize_name(name)
	if name:sub(-1):lower() == "s" then
		return name .. "es"
	end
	return name .. "s"
end

local function check_function_exists(lines, func_name)
	for _, line in ipairs(lines) do
		if line:match("func%s+" .. func_name .. "%s*%(") then
			return true
		end
	end
	return false
end

local function generate_plural_mapper()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1]

	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local func_line = lines[row]

	local func_name, param_name, param_type, return_type =
		func_line:match("func%s+(%w+)%((%w+)%s+%*([%w%.]+)%)%s+%*([%w%.]+)")

	if not func_name then
		vim.notify("error.", vim.log.levels.ERROR)
		return
	end

	local plural_func_name = pluralize_name(func_name)
	local plural_param_name = pluralize_name(param_name)

	if check_function_exists(lines, plural_func_name) then
		vim.notify(string.format("Function %s is exists!", plural_func_name), vim.log.levels.WARN)
		return
	end

	local func_end_line = row
	local brace_count = 0
	local found_start = false

	for i = row, #lines do
		local line = lines[i]
		for char in line:gmatch(".") do
			if char == "{" then
				brace_count = brace_count + 1
				found_start = true
			elseif char == "}" then
				brace_count = brace_count - 1
			end
		end

		if found_start and brace_count == 0 then
			func_end_line = i
			break
		end
	end

	local new_func = {
		"", -- Dòng trống
		string.format("func %s(%s []*%s) []*%s {", plural_func_name, plural_param_name, param_type, return_type),
		string.format("\touts := make([]*%s, 0, len(%s))", return_type, plural_param_name),
		string.format("\tfor _, %s := range %s {", param_name, plural_param_name),
		string.format("\t\touts = append(outs, %s(%s))", func_name, param_name),
		"\t}",
		"",
		"\treturn outs",
		"}",
	}

	vim.api.nvim_buf_set_lines(0, func_end_line, func_end_line, false, new_func)

	vim.api.nvim_win_set_cursor(0, { func_end_line + 2, 0 })

	vim.notify(string.format("%s was created", plural_func_name), vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("GeneratePluralMapper", generate_plural_mapper, {})

vim.keymap.set("n", "<leader>gm", generate_plural_mapper, {
	desc = "Generate plural mapper function",
	noremap = true,
	silent = true,
})

vim.keymap.set("n", "<space>gat", function()
	local tag = vim.fn.input("tag: ")
	if tag ~= "" then
		vim.cmd("GoAddTag " .. tag)
	else
		print("No tag entered, bro!")
	end
end, {
	silent = true,
	noremap = true,
	desc = "Add struct tag (ask for type)",
})

vim.keymap.set("n", "<space>gft", ":GoFillStruct<CR>", {
	silent = true,
	noremap = true,
	desc = "Fill struct fields",
})
