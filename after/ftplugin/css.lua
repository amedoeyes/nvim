vim.opt_local.formatprg = "prettier --parser css --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("vscode-css-language-server")
