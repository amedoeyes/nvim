return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		preview_config = { border = "rounded" },
		on_attach = function(buffer)
			local gitsigns = require("gitsigns")
			local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end
			map("n", "]h", function() gitsigns.nav_hunk("next") end, "Next Hunk")
			map("n", "[h", function() gitsigns.nav_hunk("prev") end, "Prev Hunk")
			map("n", "]H", function() gitsigns.nav_hunk("last") end, "Last Hunk")
			map("n", "[H", function() gitsigns.nav_hunk("first") end, "First Hunk")
			map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
			map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
			map("n", "<leader>ghS", gitsigns.stage_buffer, "Stage buffer")
			map("n", "<leader>ghu", gitsigns.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>ghR", gitsigns.reset_buffer, "Reset buffer")
			map("n", "<leader>ghp", gitsigns.preview_hunk_inline, "Preview hunk inline")
			map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, "Blame line")
			map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")
			map("n", "<leader>ghD", function() gitsigns.diffthis("~") end, "Diff this ~")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns select hunk")
		end,
	},
}
