vim.opt_local.formatprg = "prettier --parser html --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("vscode-html-language-server")
