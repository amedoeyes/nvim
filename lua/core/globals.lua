vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.markdown_recommended_style = 0
vim.g.termdebug_config = { sign = "" }

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.autoformat = true
vim.g.codelens = false

_G.project_root = {
	patterns = { ".git", ".clang-format", ".clang-tidy" },
}

_G.reload_config = {
	patterns = { "^core" },
	exclude = { "^core.plugins" },
}
