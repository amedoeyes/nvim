vim.opt_local.formatprg = "prettier --parser typescript --std-filepath %"
require("core.lsp").start("typescript-language-server")
