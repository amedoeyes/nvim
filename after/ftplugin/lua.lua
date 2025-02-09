vim.opt_local.formatprg = "stylua --stdin-filepath % -"
vim.opt_local.formatexpr = ""
require("core.lsp").start("lua-language-server")
