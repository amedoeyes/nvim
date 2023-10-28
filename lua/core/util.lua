local M = {}

---@param val boolean
---@param name string
---@param callback function(val)
M.toggle = function(val, name, callback)
	val = not val
	vim.notify(name .. ": " .. (val and "on" or "off"), vim.log.levels.INFO)

	callback(val)
end

---@param exclude table
---@param filetypes table
---@return table
M.exclude_filetypes = function(exclude, filetypes)
	return vim.tbl_filter(function(ft)
		return not vim.tbl_contains(exclude, ft)
	end, filetypes)
end

---@return string | nil
M.get_root = function()
	local git_root = vim.fn.finddir(".git", ";")
	local parent = vim.api.nvim_buf_get_name(0)
	local dir = ""

	if git_root == "" then
		dir = parent
	else
		dir = git_root
	end

	return vim.fn.fnamemodify(dir, ":h")
end

return M
