vim.opt_local.formatprg = "shfmt --filename %"
require("core.lsp").start("bash-language-server")
