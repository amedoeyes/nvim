vim.opt_local.formatprg = "prettier --parser markdown --std-filepath %"
require("core.lsp").start("marksman")
require("core.lsp").start("zk")
