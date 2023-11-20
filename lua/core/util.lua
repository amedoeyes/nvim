local M = {}

---@param on_attach function
M.lsp_on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(e)
			on_attach(vim.lsp.get_client_by_id(e.data.client_id), e.buf)
		end,
	})
end

---@param name string
---@param val boolean
M.toggle_notify = function(name, val)
	vim.notify(name .. ": " .. (val and "enabled" or "disabled"), vim.log.levels.INFO)
end

---@return string | nil
M.get_root_dir = function()
	local patterns = { ".git" }
	local root_dir = ""

	for _, pattern in ipairs(patterns) do
		local pattern_dir = vim.fn.finddir(pattern, ";")
		local pattern_file = vim.fn.findfile(pattern, ";")

		if pattern_dir ~= "" then
			root_dir = pattern_dir
			break
		elseif pattern_file ~= "" then
			root_dir = pattern_file
			break
		end
	end

	if root_dir ~= "" then
		return vim.fn.fnamemodify(root_dir, ":h")
	else
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
	end
end

return M
