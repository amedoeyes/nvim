return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	opts = function()
		local groups = require("bufferline.groups")
		local sort_by = function(buffer_a, buffer_b) return buffer_a.name < buffer_b.name end
		vim.api.nvim_create_user_command(
			"BufferLineSortByName",
			function() require("bufferline").sort_by(sort_by) end,
			{}
		)
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
					{ filetype = "copilot-chat", text = "Copilot", highlight = "Title" },
					{ filetype = "neo-tree", text = "File Tree", highlight = "Title" },
					{ filetype = "toggleterm", text = "Terminal", highlight = "Title" },
					{ filetype = "undotree", text = "Undotree", highlight = "Title" },
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
				sort_by = sort_by,
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
