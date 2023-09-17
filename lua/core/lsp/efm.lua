local black = require("efmls-configs.formatters.black")
local clang_format = require("efmls-configs.formatters.clang_format")
local flake8 = require("efmls-configs.linters.flake8")
local gersemi = require('efmls-configs.formatters.gersemi')
local prettier_d = require("efmls-configs.formatters.prettier_d")
local shfmt = require("efmls-configs.formatters.shfmt")
local stylua = require("efmls-configs.formatters.stylua")

local languages = {
	c = { clang_format },
	cmake = { gersemi },
	cpp = { clang_format },
	css = { prettier_d },
	html = { prettier_d },
	javascript = { prettier_d },
	javascriptreact = { prettier_d },
	json = { prettier_d },
	jsonc = { prettier_d },
	lua = { stylua },
	markdown = { prettier_d },
	python = { flake8, black },
	sh = { shfmt },
	typescript = { prettier_d },
	typescriptreact = { prettier_d },
	zsh = { shfmt },
}

return {
	filetypes = vim.tbl_keys(languages),
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
}
