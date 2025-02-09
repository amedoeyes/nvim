vim.opt_local.formatprg = "clang-format -assume-filename %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("clangd")
