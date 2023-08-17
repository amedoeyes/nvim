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
		inlay_hint = false,
	},

	---@param on_attach function
	on_attach = function(on_attach)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(e)
				on_attach(vim.lsp.get_client_by_id(e.data.client_id), e.buf)
			end,
		})
	end,

	setup = function()
		local icons = M.icons
		vim.diagnostic.config(M.lsp.config.diagnostic)

		for name, icon in pairs(icons.diagnostics) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
	end,
}

return M
