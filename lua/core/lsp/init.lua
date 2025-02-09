vim.lsp.set_log_level("off")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts.border = "single"
	opts.max_width = 80
	return original_open_floating_preview(contents, syntax, opts)
end

local M = {}

---@param bufnr integer
---@param patterns string[]
---@return string|nil
local function find_root(bufnr, patterns)
	local paths = vim.fs.find(function(name, path)
		for _, p in ipairs(patterns) do
			if vim.fn.globpath(path, p) ~= "" or name == p then return true end
		end
		return false
	end, {
		path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h"),
		upward = true,
	})
	return #paths > 0 and vim.fs.dirname(paths[1]) or nil
end

---@param server string
M.start = function(server)
	local buf = vim.api.nvim_get_current_buf()
	local config = require("core.lsp.configs." .. server)
	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
	config.root_patterns = config.root_patterns or {}
	table.insert(config.root_patterns, ".get")
	config.root_dir = find_root(buf, config.root_patterns)
	local client_id = vim.lsp.start(config, {
		reuse_client = function(c, cfg) return c.name == cfg.name and c.config.root_dir == cfg.root_dir end,
	})
	if not client_id then return end
	local client = vim.lsp.get_client_by_id(client_id)
	if not client then return end
	if not config.name then config.name = client.name end
	if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("eyes.lsp.codelens", { clear = false }),
			buffer = buf,
			callback = function()
				if vim.g.codelens then vim.lsp.codelens.refresh({ bufnr = buf }) end
			end,
		})
	end
	if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
		vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
	end
end

return M
