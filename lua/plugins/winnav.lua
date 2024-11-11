return {
	"amedoeyes/nvim-winnav",
	lazy = false,
	opts = {
		direction_map = {
			h = "left",
			l = "right",
			k = "up",
			j = "down",
		},
		focus_command = { "swaymsg", "focus" },
	},
}
