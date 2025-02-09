vim.opt_local.formatprg = "prettier --parser json --std-filepath %"
require("core.lsp").start("vscode-json-language-server")
