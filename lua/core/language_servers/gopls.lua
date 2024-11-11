return {
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				test = true,
				tidy = true,
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
				unusedvariable = true,
				useany = true,
			},
			usePlaceholders = true,
			staticcheck = true,
			semanticTokens = true,
		},
	},
}
