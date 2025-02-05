return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "saghen/blink.cmp", lazy = true },
		{ "b0o/SchemaStore.nvim", lazy = true },
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			"asm_lsp",
			"bashls",
			"clangd",
			"cssls",
			"eslint",
			"glsl_analyzer",
			"gopls",
			"hls",
			"html",
			"jsonls",
			"lua_ls",
			"marksman",
			"pylsp",
			"taplo",
			"ts_ls",
			"zk",
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
		for _, server in ipairs(opts.servers) do
			local ok, config = pcall(require, "core.language_servers." .. server)
			config = ok and config or {}
			config.capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			lspconfig[server].setup(config)
		end
	end,
}
