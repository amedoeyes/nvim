return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
		"MasonUpdate",
		"MasonUpdateAll",
	},
	lazy = true,
	opts = {
		ui = { border = "rounded" },
		ensure_installed = {
			"haskell-language-server",
			"arduino-language-server",
			"asm-lsp",
			"asmfmt",
			"bash-language-server",
			"black",
			"clangd",
			"codelldb",
			"css-lsp",
			"emmet-language-server",
			"eslint-lsp",
			"glsl_analyzer",
			"hyprls",
			"json-lsp",
			"lua-language-server",
			"marksman",
			"prettier",
			"python-lsp-server",
			"shellcheck",
			"shfmt",
			"stylua",
			"taplo",
			"texlab",
			"typescript-language-server",
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)
		local registry = require("mason-registry")
		local notify = require("mason-core.notify")
		registry.refresh(function()
			for _, tool in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(tool)
				if not pkg:is_installed() then
					pkg:install()
					notify("Installing " .. tool)
				end
			end
		end)
		local command = vim.api.nvim_create_user_command
		command("MasonUpdateAll", function()
			local up_to_date = true
			for _, tool in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(tool)
				pkg:check_new_version(function(success, result_or_err)
					if not success then return end
					up_to_date = false
					pkg:install()
					notify("Updating " .. result_or_err.name)
				end)
			end
			if up_to_date then notify("All tools are up-to-date") end
		end, {})
	end,
}
