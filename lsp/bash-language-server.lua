return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
}
