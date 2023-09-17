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
M.filetypes_exclude = function(exclude, filetypes)
	return vim.tbl_filter(function(ft)
		return not vim.tbl_contains(exclude, ft)
	end, filetypes)
end

return M
