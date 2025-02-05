return {
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				test = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				shadow = true,
			},
			usePlaceholders = true,
			staticcheck = true,
			semanticTokens = true,
		},
	},
}
