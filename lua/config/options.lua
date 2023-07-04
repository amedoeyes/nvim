local opt = vim.opt

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = false
opt.pumblend = 0
opt.fillchars:append({ eob = " " })
opt.listchars:append({ trail = " " })
opt.listchars:append({ tab = "  " })
opt.spelloptions = "camel"
opt.conceallevel = 0
