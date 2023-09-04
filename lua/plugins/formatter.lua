return {
	"mhartington/formatter.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local f = require("formatter.filetypes")

		return {
			filetype = {
				c = { f.c.clangformat },
				cmake = { f.cmake.cmakeformat },
				cpp = { f.cpp.clangformat },
				css = { f.css.prettier },
				html = { f.html.prettier },
				javascript = { f.javascript.prettier },
				javascriptreact = { f.javascriptreact.prettier },
				jsonc = { f.json.prettier },
				json = { f.json.prettier },
				lua = { f.lua.stylua },
				markdown = { f.markdown.prettier },
				python = { f.python.black },
				sh = { f.sh.shfmt },
				typescript = { f.typescript.prettier },
				typescriptreact = { f.typescriptreact.prettier },
				zsh = { f.sh.shfmt },
				["*"] = { f.any.remove_trailing_whitespace },
			},
		}
	end,
	config = function(_, opts)
		require("formatter").setup(opts)

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
			callback = function()
				vim.cmd("FormatWriteLock")
			end,
		})
	end,
	keys = {
		{
			"<leader>cf",
			":FormatWrite<cr>",
			mode = { "n", "v" },
			desc = "Format",
			silent = true,
		},
	},
}
