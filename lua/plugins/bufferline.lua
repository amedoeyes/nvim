return {
	"akinsho/bufferline.nvim",
	event = "VimEnter",
	opts = function()
		local groups = require("bufferline.groups")

		return {
			options = {
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = require("core.icons")

					local ret = (diag.error and icons.diagnostics.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")

					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},
				tab_size = 10,
				show_buffer_close_icons = false,
				separator_style = { "|", "|" },
				indicator = { style = "none" },
				groups = {
					items = { groups.builtin.pinned:with({ icon = "" }) },
				},
			},
			highlights = require("eyes.theme").bufferline,
		}
	end,
	keys = {
		{
			"<S-l>",
			"<cmd>BufferLineCycleNext<cr>",
			desc = "Next buffer",
		},
		{
			"<S-h>",
			"<cmd>BufferLineCyclePrev<cr>",
			desc = "Previous buffer",
		},
		{
			"<leader>bp",
			"<cmd>BufferLineTogglePin<cr>",
			desc = "Pin buffer",
		},
		{
			"<leader>bR",
			"<cmd>BufferLineGroupClose ungrouped<cr>",
			desc = "Remove ungrouped buffers",
		},
	},
}
