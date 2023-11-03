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
