vim.api.nvim_create_user_command("ProjectRoot", function()
	local project_root = _G.project_root
	local root = vim.fs.root(0, project_root.patterns) or vim.fs.dirname(vim.api.nvim_buf_get_name(0))
	vim.cmd("cd " .. root)
	vim.notify("Project root: " .. root)
end, {})

vim.api.nvim_create_user_command("ReloadConfig", function()
	local reload_config = _G.reload_config
	for name, _ in pairs(package.loaded) do
		for _, pattern in ipairs(reload_config.exclude) do
			if name:match(pattern) then goto skip end
		end
		for _, pattern in ipairs(reload_config.patterns) do
			if name:match(pattern) then package.loaded[name] = nil end
		end
		::skip::
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Config reloaded")
end, {})
