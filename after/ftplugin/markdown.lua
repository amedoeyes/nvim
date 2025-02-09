vim.opt_local.formatprg = "prettier --parser markdown --std-filepath %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("marksman")
require("core.lsp").start("zk")
