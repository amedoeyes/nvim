return {
	"zk-org/zk-nvim",
	cmd = {
		"ZkIndex",
		"ZkNew",
		"ZkNewFromTitleSelection",
		"ZkNewFromContentSelection",
		"ZkCd",
		"ZkNotes",
		"ZkBacklinks",
		"ZkLinks",
		"ZkMatch",
		"ZkTags",
	},
	ft = { "markdown" },
	opts = { picker = "telescope" },
	config = function(_, opts)
		require("zk").setup(opts)
	end,
}
