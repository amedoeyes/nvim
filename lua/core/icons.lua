local M = {}

M.dap = {
	Stopped = "",
	Breakpoint = "",
	BreakpointCondition = "",
	BreakpointRejected = "",
	LogPoint = "",
}

M.diagnostics = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

M.kinds = {
	Class = "",
	Codeium = "󰘦",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "",
	Interface = "",
	Keyword = "",
	Method = "",
	Module = "",
	Operator = "",
	Property = "",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "󰎠",
	Variable = "",
}

return M
