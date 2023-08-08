require("config.options")
require("config.autocmds")
require("config.commands")
require("config.keymaps")
require("config.lazy")

if vim.g.neovide then
	require("config.neovide")
end
