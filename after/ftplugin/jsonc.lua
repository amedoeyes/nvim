vim.opt_local.formatprg = "prettier --parser jsonc --std-filepath %"
require("core.lsp").start("vscode-json-language-server")
