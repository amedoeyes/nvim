return {
	settings = {
		pylsp = {
			plugins = {
				flake8 = {
					enabled = true,
					ignore = { "E203", "E501" },
				},
				pycodestyle = { enabled = false },
			},
		},
	},
}
