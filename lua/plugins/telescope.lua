return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	event = "VeryLazy",
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			prompt_prefix = " ",
			selection_caret = " ",
		},
	},
	keys = {
		{
			"<leader>bf",
			"<cmd>Telescope buffers<cr>",
			desc = "Find buffer",
		},
		{
			"<leader>bs",
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			desc = "Search buffer",
		},
		{
			"<leader>cs",
			"<cmd>Telescope spell_suggest<cr>",
			desc = "Spell suggestions",
		},
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles<cr>",
			desc = "Recent files",
		},
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find file",
		},
		{
			"<leader>fs",
			"<cmd>Telescope live_grep<cr>",
			desc = "Search files",
		},
		{
			"<leader>xs",
			"<cmd>Telescope diagnostics<cr>",
			desc = "Search diagnostics",
		},
		{
			"gr",
			"<CMD>Telescope lsp_references<CR>",
			desc = "Go to references",
		},
	},
}
