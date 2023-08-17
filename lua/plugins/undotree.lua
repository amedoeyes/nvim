return {
	"mbbill/undotree",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>bu",
			"<cmd>UndotreeToggle<cr>",
			desc = "Undotree",
		},
	},
}
