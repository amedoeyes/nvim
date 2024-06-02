local command = vim.api.nvim_create_user_command
local utils = require("core.utils")

command("ProjectRoot", function() vim.cmd("cd " .. utils.get_root_dir()) end, {})

command("ReloadConfig", function() utils.reload_config() end, {})
