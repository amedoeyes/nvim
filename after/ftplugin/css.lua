vim.opt_local.formatprg = "prettier --parser css --std-filepath %"
require("core.lsp").start("vscode-css-language-server")
