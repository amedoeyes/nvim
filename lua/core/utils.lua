local M = {}

---@param tbl table
---@param name string
---@return boolean
local toggle_table = function(tbl, name)
	tbl[name] = not tbl[name]
	vim.notify(name .. ": " .. (tbl[name] and "enabled" or "disabled"), vim.log.levels.INFO)
	return tbl[name]
end

---@param name string
---@return boolean
M.toggle_global = function(name) return toggle_table(vim.g, name) end

---@param name string
---@return boolean
M.toggle_option = function(name) return toggle_table(vim.o, name) end

---@return string
M.get_root_dir = function()
	local patterns = { ".git", ".clang-format", ".clang-tidy" }
	local root_dir = vim.fs.root(0, patterns)
	return root_dir and root_dir or vim.fs.dirname(vim.api.nvim_buf_get_name(0))
end

M.reload_config = function()
	local patterns = { "^core", "^language_servers", "^debuggers" }
	local exclude = { "core.plugins" }
	for name, _ in pairs(package.loaded) do
		for _, pattern in ipairs(exclude) do
			if name:match(pattern) then goto skip end
		end
		for _, pattern in ipairs(patterns) do
			if name:match(pattern) then package.loaded[name] = nil end
		end
		::skip::
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Config reloaded", vim.log.levels.INFO)
end

M.lsp = {}

---@param callback function
M.lsp.on_attach = function(callback)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp_attach", { clear = false }),
		callback = function(e) callback(vim.lsp.get_client_by_id(e.data.client_id), e.buf) end,
	})
end

---@param method string
---@param callback function
M.lsp.on_supports_method = function(method, callback)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp_support_method", { clear = false }),
		callback = function(e)
			local client = vim.lsp.get_client_by_id(e.data.client_id)
			if client and client.supports_method(method) then callback(client, e.buf) end
		end,
	})
end

---@param from string
---@param to string
M.lsp.rename_file = function(from, to)
	local clients = vim.lsp.get_clients()
	for _, client in ipairs(clients) do
		if client.supports_method("workspace/willRenameFiles") then
			local res = client.request_sync("workspace/willRenameFiles", {
				files = {
					{
						oldUri = vim.uri_from_fname(from),
						newUri = vim.uri_from_fname(to),
					},
				},
			}, 1000, 0)
			if res and res.result then vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding) end
		end
	end
end

return M
