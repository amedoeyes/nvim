local opt = vim.opt
local g = vim.g

opt.guifont = "JetBrainsMono Nerd Font:h9.6"

if vim.g.neovide then
	g.neovide_hide_mouse_when_typing = true
	g.neovide_cursor_trail_size = 0
end
