vim.opt_local.formatprg = "black --quiet -"
vim.opt_local.formatexpr = ""
require("core.lsp").start("pylsp")
