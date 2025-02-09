vim.opt_local.formatprg = "stylua --stdin-filepath % -"
require("core.lsp").start("lua-language-server")
