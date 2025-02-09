vim.opt_local.formatprg = "prettier --parser scss --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("vscode-css-language-server")
