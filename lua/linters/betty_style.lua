local severities = {
	ERROR = vim.diagnostic.severity.ERROR,
	WARNING = vim.diagnostic.severity.WARN,
}

local pattern = "[^:]+:(%d+): (%w+): (.*)"
local groups = { "lnum", "severity", "message" }

return {
	cmd = "betty-style",
	stdin = false,
	args = {
		"-q",
		"--no-summary",
	},
	ignore_exitcode = true,
	parser = require("lint.parser").from_pattern(pattern, groups, severities, {
		source = "betty-style",
	}),
}
