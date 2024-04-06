vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.autoformat = true

vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdgm"

vim.opt.clipboard = "unnamedplus"
vim.opt.formatoptions = "jcroqlnt"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.timeoutlen = 300
vim.opt.conceallevel = 2

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.guicursor:append("a:blinkon100-blinkoff100")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.list = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.shortmess:append({ I = true, c = true })
vim.opt.termguicolors = true

vim.opt.fillchars:append({ eob = " " })
vim.opt.listchars:append({ trail = " ", tab = "  " })

vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menu,menuone,noinsert"
vim.opt.pumheight = 10

vim.opt.splitkeep = "screen"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winminwidth = 5

vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.swapfile = false

vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"

vim.opt.spelllang = { "en" }
vim.opt.spelloptions = "camel"
