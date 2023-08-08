local command = vim.api.nvim_buf_create_user_command

local lsp = require("config.lsp")

lsp.on_attach(function(_, buffer)
	command(buffer, "Format", function()
		lsp.format()
	end, { desc = "Format current buffer with LSP" })

	command(buffer, "FormatToggle", function()
		lsp.toggle.autoformat()
	end, { desc = "Autoformat toggle" })

	command(buffer, "InlayHintToggle", function()
		lsp.toggle.inlay_hint()
	end, { desc = "Inlay hint toggle" })
end)
