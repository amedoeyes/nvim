vim.opt_local.formatprg = "dotnet-csharpier --write-stdout"
vim.opt_local.formatexpr = ""
require("core.lsp").start("omnisharp")
