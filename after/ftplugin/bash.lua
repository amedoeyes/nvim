vim.opt_local.formatprg = "shfmt --filename %"
vim.opt_local.formatexpr = ""
require("core.lsp").start("bash-language-server")
