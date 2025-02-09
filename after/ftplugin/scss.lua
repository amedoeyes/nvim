vim.opt_local.formatprg = "prettier --parser scss --std-filepath %"
require("core.lsp").start("vscode-css-language-server")
