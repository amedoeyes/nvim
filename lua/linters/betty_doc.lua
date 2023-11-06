local severities = {
	error = vim.diagnostic.severity.ERROR,
	warning = vim.diagnostic.severity.WARN,
	info = vim.diagnostic.severity.INFO,
	style = vim.diagnostic.severity.HINT,
}

return {
	cmd = "betty-doc",
	stdin = false,
	ignore_exitcode = true,
	stream = "stderr",
	parser = function(output)
		local diagnostics = {}

		for _, line in ipairs(vim.split(output, "\n")) do
			if vim.startswith(line, vim.fn.expand("%:p")) then
				local parsed = vim.split(line, ":")

				table.insert(diagnostics, {
					lnum = tonumber(parsed[2]) - 1,
					col = 0,
					severity = severities[string.lower(vim.trim(parsed[3]))],
					message = vim.trim(parsed[4]),
				})
			end
		end

		return diagnostics
	end,
}
