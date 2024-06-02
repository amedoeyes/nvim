return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = function()
		local groups = require("bufferline.groups")
		return {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, d)
					local icons = vim.diagnostic.config().signs.text
					if icons == nil then return end
					local error = d.error and icons[vim.diagnostic.severity.ERROR] .. d.error or ""
					local warning = d.warning and icons[vim.diagnostic.severity.WARN] .. d.warning or ""
					local info = d.info and icons[vim.diagnostic.severity.INFO] .. d.info or ""
					return vim.trim(error .. " " .. warning .. " " .. info)
				end,
				offsets = {
					{ filetype = "neo-tree", text = "File Tree", highlight = "Title" },
					{ filetype = "undotree", text = "Undotree", highlight = "Title" },
					{ filetype = "copilot-chat", text = "Copilot", highlight = "Title" },
				},
				tab_size = 10,
				show_buffer_close_icons = false,
				separator_style = { "|", "|" },
				indicator = { style = "none" },
				groups = {
					items = {
						groups.builtin.pinned:with({ icon = "" }),
						groups.builtin.ungrouped,
					},
				},
			},
			highlights = require("eyes.theme").bufferline,
		}
	end,
	keys = {
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Bufferline next" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Bufferline prev" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Bufferline move next" },
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Bufferline move prev" },
	},
}
