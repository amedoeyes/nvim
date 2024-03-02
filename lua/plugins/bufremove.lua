return {
	"echasnovski/mini.bufremove",
	version = false,
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>br",
			function()
				require("mini.bufremove").delete(0, false)
			end,
			desc = "Remove buffer",
		},
	},
}
