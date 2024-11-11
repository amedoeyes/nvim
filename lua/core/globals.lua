vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.autoformat = true
vim.g.codelens = false

_G.zenmode = {
	enabled = false,
	opts = {
		number = false,
		relativenumber = false,
		showtabline = 0,
		laststatus = 0,
		statuscolumn = "",
	},
	_opts = {},
}

_G.project_root = {
	patterns = { ".git", ".clang-format", ".clang-tidy" },
}

_G.reload_config = {
	patterns = { "^core" },
	exclude = { "^core.plugins" },
}
