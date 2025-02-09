return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				autopep8 = { enabled = false },
				black = { enabled = true },
				flake8 = { enabled = true },
				mccabe = { enabled = false },
				pycodestyle = { enabled = false },
				pyflakes = { enabled = false },
				pyls_isort = { enabled = false },
				rope = { enabled = true },
				ruff = { enabled = false },
				yapf = { enabled = false },
			},
		},
	},
	root_markers = { "pyproject.toml", "requirements.txt" },
}
