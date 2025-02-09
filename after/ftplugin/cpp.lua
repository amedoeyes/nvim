vim.opt_local.formatprg = "clang-format --assume-filename %"
require("core.lsp").start("clangd")
