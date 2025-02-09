---@param buf integer
---@param range? {start_line: integer, end_line: integer}
local function format(buf, range)
	if vim.bo.formatprg ~= "" then
		local start_line = range and (range.start_line - 1) or 0
		local end_line = range and range.end_line or -1
		local original_lines = vim.api.nvim_buf_get_lines(buf, start_line, end_line, true)
		local formatted_lines = vim.fn.systemlist(vim.bo.formatprg, original_lines)
		if vim.v.shell_error ~= 0 then return end
		local diff = vim.diff(
			table.concat(original_lines, "\n"),
			table.concat(formatted_lines, "\n"),
			{ result_type = "indices" }
		)
		if vim.tbl_isempty(diff) then return end
		local text_edits = {}
		for _, hunk in ipairs(diff) do
			local start_a, count_a, start_b, count_b = table.unpack(hunk)
			local replacement_lines = vim.list_slice(formatted_lines, start_b, start_b + count_b - 1)
			table.insert(text_edits, {
				range = {
					start = { line = start_line + start_a - 1, character = 0 },
					["end"] = { line = start_line + start_a - 1 + count_a, character = 0 },
				},
				newText = table.concat(replacement_lines, "\n") .. "\n",
			})
		end
		vim.lsp.util.apply_text_edits(text_edits, buf, "utf-16")
	else
		if
			not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = buf, method = "textDocument/formatting" }))
		then
			vim.lsp.buf.format({ bufnr = buf, range = range })
		end
	end
	vim.diagnostic.show(nil, 0)
end

function FormatExpr()
	local buf = vim.api.nvim_get_current_buf()
	if vim.v.count == vim.fn.line("$") then
		format(buf)
		return 0
	end
	local start_line = vim.v.lnum
	local end_line = start_line + vim.v.count - 1
	if start_line <= 0 or end_line <= 0 then return 0 end
	format(buf, { start_line = start_line, end_line = end_line })
	return 0
end

vim.opt.formatexpr = "v:lua.FormatExpr()"

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(e)
		if not vim.g.autoformat then return end
		format(e.buf)
	end,
})
