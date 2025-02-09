vim.opt_local.formatprg = "prettier --parser typescript --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("typescript-language-server")
