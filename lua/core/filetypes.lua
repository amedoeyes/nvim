vim.filetype.add({
	extension = {
		vert = "glsl",
		geom = "glsl",
		frag = "glsl",
		tesc = "glsl",
		tese = "glsl",
		comp = "glsl",
	},
	pattern = {
		[".*/sway/.*%.conf"] = "swayconfig",
	},
})
