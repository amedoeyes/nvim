return {
	"williamboman/mason.nvim",
	build = ":MasonUpdateAll",
	lazy = true,
	cmd = {
		"Mason",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
		"MasonUpdate",
		"MasonUpdateAll",
	},
	opts = {
		ensure_installed = {
			"asm-lsp",
			"asmfmt",
			"bash-language-server",
			"black",
			"clangd",
			"codelldb",
			"csharpier",
			"css-lsp",
			"eslint-lsp",
			"glsl_analyzer",
			"gofumpt",
			"gopls",
			"haskell-language-server",
			"html-lsp",
			"json-lsp",
			"lua-language-server",
			"marksman",
			"omnisharp",
			"prettier",
			"python-lsp-server",
			"shellcheck",
			"shfmt",
			"stylua",
			"taplo",
			"typescript-language-server",
		},
		ui = { border = "single" },
	},
	config = function(_, opts)
		require("mason").setup(opts)
		local registry = require("mason-registry")
		local notify = require("mason-core.notify")
		registry.refresh(function()
			for _, tool in ipairs(opts.ensure_installed) do
				local pkg = registry.get_package(tool)
				if not pkg:is_installed() then
					notify("Installing " .. tool)
					pkg:install()
				end
			end
		end)
		vim.api.nvim_create_user_command("MasonUpdateAll", function()
			registry.update(function(update_success, _)
				if not update_success then
					return
				end
				local up_to_date = true
				for _, tool in ipairs(opts.ensure_installed) do
					local pkg = registry.get_package(tool)
					pkg:check_new_version(function(check_success, result_or_err)
						if not check_success then
							return
						end
						up_to_date = false
						pkg:install()
						notify("Updating " .. result_or_err.name)
					end)
				end
				if up_to_date then
					notify("All tools are up-to-date")
				end
			end)
		end, {})
	end,
}
