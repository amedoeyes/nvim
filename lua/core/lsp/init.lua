vim.lsp.set_log_level("off")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts.border = "single"
	opts.max_width = 80
	return original_open_floating_preview(contents, syntax, opts)
end

local servers_by_ft = {
	bash = { "bash-language-server" },
	c = { "clangd" },
	javascript = { "typescript-language-server" },
	javascriptreact = { "typescript-language-server" },
	typescript = { "typescript-language-server" },
	typescriptreact = { "typescript-language-server" },
	comp = { "glslls" },
	cpp = { "clangd" },
	css = { "vscode-css-language-server" },
	frag = { "glslls" },
	geom = { "glslls" },
	glsl = { "glslls" },
	go = { "gopls" },
	gomod = { "gopls" },
	gotmpl = { "gopls" },
	gowork = { "gopls" },
	haskell = { "haskell-language-server" },
	html = { "vscode-html-language-server" },
	json = { "json-language-server" },
	jsonc = { "json-language-server" },
	less = { "vscode-css-language-server" },
	lua = { "lua-language-server" },
	markdown = { "marksman", "zk" },
	cs = { "omnisharp" },
	python = { "pylsp" },
	scss = { "vscode-css-language-server" },
	sh = { "bash-language-server" },
	tesc = { "glslls" },
	tese = { "glslls" },
	vert = { "glslls" },
	zsh = { "bash-language-server" },
}

local function find_root(bufnr, patterns)
	local paths = vim.fs.find(function(name, path)
		for _, p in ipairs(patterns) do
			if vim.fn.globpath(path, p) ~= "" or name == p then return true end
		end
		return false
	end, {
		path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:h"),
		upward = true,
	})
	vim.print(vim.inspect(paths))
	return #paths > 0 and vim.fs.dirname(paths[1]) or nil
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("eyes.lsp", { clear = true }),
	callback = function(e)
		vim.api.nvim_create_autocmd("FileType", {
			buffer = e.buf,
			once = true,
			callback = function()
				vim
					.iter(servers_by_ft[vim.bo[e.buf].filetype] or {})
					:map(function(server) return require("core.lsp.servers." .. server) end)
					:each(function(server)
						if not server._start then
							server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
							server.root_patterns = server.root_patterns or {}
							table.insert(server.root_patterns, ".get")
							server.root_dir = find_root(e.buf, server.root_patterns)
							vim.notify(server.root_dir)
							local client_id = vim.lsp.start(server)
							if client_id then
								local client = vim.lsp.get_client_by_id(client_id)
								if client then
									server._client = client
									server._start = true
								end
							end
						else
							server._client:on_attach(e.buf)
						end
						if server._client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
							vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
								group = vim.api.nvim_create_augroup("eyes.lsp.codelens", { clear = false }),
								buffer = e.buf,
								callback = function()
									if vim.g.codelens then vim.lsp.codelens.refresh({ bufnr = e.buf }) end
								end,
							})
						end
						if server._client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
							vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
						end
					end)
			end,
		})
	end,
})
