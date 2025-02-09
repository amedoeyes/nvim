vim.opt_local.formatprg = "prettier --parser html --std-filepath %"
require("core.lsp").start("vscode-html-language-server")
