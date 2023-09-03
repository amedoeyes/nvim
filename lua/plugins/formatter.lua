return {
	"mhartington/formatter.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local formatter_filetypes = require("formatter.filetypes")

		return {
			filetype = {
				c = {
					formatter_filetypes.c.clangformat,
				},
				cmake = {
					formatter_filetypes.cmake.cmakeformat,
				},
				cpp = {
					formatter_filetypes.cpp.clangformat,
				},
				css = {
					formatter_filetypes.css.prettierd,
				},
				html = {
					formatter_filetypes.html.prettierd,
				},
				javascript = {
					formatter_filetypes.javascript.prettierd,
				},
				javascriptreact = {
					formatter_filetypes.javascriptreact.prettierd,
				},
				json = {
					formatter_filetypes.json.prettierd,
				},
				jsonc = {
					formatter_filetypes.json.prettierd,
				},
				lua = {
					formatter_filetypes.lua.stylua,
				},
				markdown = {
					formatter_filetypes.markdown.prettierd,
				},
				python = {
					formatter_filetypes.python.black,
				},
				sh = {
					formatter_filetypes.sh.shfmt,
				},
				typescript = {
					formatter_filetypes.typescript.prettierd,
				},
				typescriptreact = {
					formatter_filetypes.typescriptreact.prettierd,
				},
				zsh = {
					formatter_filetypes.sh.shfmt,
				},
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		}
	end,
	config = function(_, opts)
		require("formatter").setup(opts)

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
			callback = function()
				vim.cmd("FormatWrite")
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
