return {
	"Exafunction/codeium.vim",
	event = "InsertEnter",
	config = function()
		vim.g.codeium_no_map_tab = true
		vim.g.codeium_enabled = true
	end,
}
