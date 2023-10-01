return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local nls = require("null-ls")

		return {
			sources = {
				nls.builtins.formatting.black,
				nls.builtins.formatting.clang_format,
				nls.builtins.formatting.cmake_format,
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.shfmt,
				nls.builtins.formatting.stylua,

				nls.builtins.diagnostics.cmake_lint,
				nls.builtins.diagnostics.flake8,
			},
			border = "rounded",
		}
	end,
}
