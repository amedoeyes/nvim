local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"--depth=1",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "plugins",
	ui = { border = "single" },
	dev = {
		path = "~/projects/programming/",
		patterns = { "amedoeyes" },
	},
	change_detection = {
		notify = false,
	},
})

vim.cmd.packadd("termdebug")
