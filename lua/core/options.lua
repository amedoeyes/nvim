local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noinsert"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.fillchars = { diff = "╱", eob = " ", fold = " ", foldclose = "", foldopen = "", foldsep = " " }
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guicursor:append("n-v-c:blinkon100-blinkoff100")
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.listchars:append({ tab = "  ", trail = " " })
opt.number = true
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ C = true, I = true, W = true, c = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.spelloptions = "camel"
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
