local M = {}

M.icons = {
	dap = {
		Stopped = "󰁕",
		Breakpoint = "",
		BreakpointCondition = "",
		BreakpointRejected = "",
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	kinds = {
		Array = "",
		Boolean = "",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Copilot = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},
}

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

M.lsp = {
	config = {
		diagnostic = {
			underline = true,
			update_in_insert = true,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
			float = {
				style = "minimal",
				border = "rounded",
				header = "",
			},
		},
		autoformat = true,
		inlay_hint = false,
	},

	format = function()
		local buffer = vim.api.nvim_get_current_buf()
		local clients = vim.lsp.get_clients()
		local filetype = vim.bo[buffer].filetype
		local formatters = require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING")
		local client_ids = {}

		for _, client in pairs(clients) do
			if
				client.supports_method("textDocument/formatting")
				or client.supports_method("textDocument/rangeFormatting")
			then
				if #formatters > 0 and client.name == "null-ls" then
					table.insert(client_ids, client.id)
				end
				if #formatters == 0 and client.name ~= "null-ls" then
					table.insert(client_ids, client.id)
				end
			end
		end

		vim.lsp.buf.format({
			bufnr = vim.api.nvim_get_current_buf(),
			filter = function(c)
				return vim.tbl_contains(client_ids, c.id)
			end,
		})
	end,

	---@param on_attach function
	on_attach = function(on_attach)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				on_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
			end,
		})
	end,

	setup = function()
		local icons = require("config.util").icons
		vim.diagnostic.config(M.lsp.config.diagnostic)

		for name, icon in pairs(icons.diagnostics) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
	end,
}

return M
