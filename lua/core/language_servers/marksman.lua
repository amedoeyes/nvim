return {
	on_attach = function(client)
		if vim.fn.expand("%:p:h"):match("^" .. os.getenv("ZK_NOTEBOOK_DIR")) then
			vim.lsp.stop_client(client.id)
		end
	end,
}
