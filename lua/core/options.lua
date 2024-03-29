local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

g.autoformat = true
g.inlayhint = false

opt.clipboard = "unnamedplus"
opt.formatoptions = "jcroqlnt"
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.timeoutlen = 300

opt.wrap = false
opt.linebreak = true

opt.cursorline = true
opt.mouse = "a"
opt.guicursor:append("a:blinkon100-blinkoff100")

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.list = true

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

opt.laststatus = 0
opt.showmode = false
opt.shortmess:append({ I = true, c = true })
opt.termguicolors = true

opt.fillchars:append({ eob = " " })
opt.listchars:append({ trail = " ", tab = "  " })

opt.wildmode = "longest:full,full"
opt.completeopt = "menu,menuone,noinsert"
opt.pumheight = 10

opt.splitkeep = "screen"
opt.splitbelow = true
opt.splitright = true
opt.winminwidth = 5

opt.autowrite = true
opt.confirm = true
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false

opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

opt.spelllang = { "en" }
opt.spelloptions = "camel"
