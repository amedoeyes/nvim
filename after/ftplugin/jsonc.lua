vim.opt_local.formatprg = "prettier --parser jsonc --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("vscode-json-language-server")
