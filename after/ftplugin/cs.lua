vim.opt_local.formatprg = "dotnet-csharpier --write-stdout"
require("core.lsp").start("omnisharp")
