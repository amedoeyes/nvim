return {
	"echasnovski/mini.surround",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
			update_n_lines = "gsn",
			suffix_next = "]",
			suffix_last = "[",
		},
	},
}
