local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--depth=1",
		"https://github.com/echasnovski/mini.nvim",
		mini_path,
	})
	vim.cmd("packadd mini.nvim | helptags ALL")
end

local deps = require("mini.deps")

deps.setup({ path = { package = path_package } })

deps.add({
	source = "saghen/blink.cmp",
	depends = { "rafamadriz/friendly-snippets" },
	checkout = "v0.11.0",
})
deps.add({ name = "eyes.nvim" })
deps.add("stevearc/oil.nvim")
deps.add("MeanderingProgrammer/render-markdown.nvim")
deps.add("folke/snacks.nvim")
deps.add({
	source = "nvim-treesitter/nvim-treesitter",
	hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
})

require("plugins.blink_cmp")
require("plugins.eyes")
require("plugins.mini")
require("plugins.render_markdown")
require("plugins.snacks")
require("plugins.termdebug")
require("plugins.treesitter")
