vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.exrc = true
vim.opt.fillchars = {
	diff = "╱",
	eob = " ",
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	lastline = " ",
}
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.lsp.foldtext()"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci-ve:ver100",
	"r-cr:hor100",
	"o:hor100",
	"a:blinkwait500-blinkoff500-blinkon500-Cursor/lCursor",
}
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:-1"
vim.opt.list = true
vim.opt.listchars:append({ tab = "  ", trail = " " })
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.pumwidth = 20
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ C = true, I = true, c = true })
vim.opt.showtabline = 1
vim.opt.sidescrolloff = 8
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.winminwidth = 5
vim.opt.wrap = false
