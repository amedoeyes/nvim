return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	settings = {
		haskell = {
			formattingProvider = "ormolu",
			cabalFormattingProvider = "cabalfmt",
		},
	},
	root_patterns = { "*.cabal" },
}
