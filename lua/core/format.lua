local function format(buf, range)
	if vim.bo.formatprg ~= "" then
		local output = vim.fn.system(vim.bo.formatprg, vim.api.nvim_buf_get_lines(buf, 0, -1, true))
		if vim.v.shell_error ~= 0 then return 1 end
		local formatted_lines = vim.split(output, "\n", { plain = true, trimempty = true })
		if range then
			formatted_lines = vim.list_slice(formatted_lines, range.start[1], range["end"][1])
			vim.api.nvim_buf_set_lines(buf, range.start[1] - 1, range["end"][1], false, formatted_lines)
		else
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted_lines)
		end
		vim.diagnostic.show(nil, 0)
	else
		local clients = vim.lsp.get_clients({
			bufnr = 0,
			method = vim.lsp.protocol.Methods.textDocument_formatting,
		})
		if #clients > 0 then vim.lsp.buf.format({ bufnr = buf, range = range }) end
	end
	vim.diagnostic.show(nil, 0)
end

function FormatExpr()
	local buf = vim.api.nvim_get_current_buf()
	if vim.v.count == vim.fn.line("$") then
		format(buf)
		return 0
	end
	local start_lnum = vim.v.lnum
	local end_lnum = start_lnum + vim.v.count - 1
	if start_lnum <= 0 or end_lnum <= 0 then return 0 end
	local end_line = vim.fn.getline(end_lnum)
	local end_col = end_line:len()
	local range = {
		start = { start_lnum, 0 },
		["end"] = { end_lnum, end_col },
	}
	format(buf, range)
	return 0
end

vim.opt.formatexpr = "v:lua.FormatExpr()"

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(e) format(e.buf) end,
})
