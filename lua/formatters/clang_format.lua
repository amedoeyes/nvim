return {
	command = "clang-format",
	args = { "--assume-filename", "$FILENAME" },
	stdin = true,
}
