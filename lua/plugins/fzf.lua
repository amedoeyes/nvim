return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	init = function()
		require("fzf-lua").register_ui_select(function(fzf_opts, items)
			return vim.tbl_deep_extend("force", fzf_opts, {
				prompt = " ",
				winopts = {
					title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
					title_pos = "center",
				},
			}, fzf_opts.kind ~= "codeaction" and {
				winopts = {
					width = 0.5,
					height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
				},
			} or {})
		end)
	end,
	opts = {
		"default-title",
		fzf_colors = true,
		previewers = {
			builtin = {
				extensions = {
					["png"] = "chafa",
					["jpg"] = "chafa",
					["jpeg"] = "chafa",
					["gif"] = "chafa",
					["webp"] = "chafa",
				},
			},
		},
		winopts = {
			width = 0.8,
			height = 0.8,
			row = 0.5,
			col = 0.5,
			border = "single",
		},
		files = {
			cwd_prompt = false,
			file_icons = "mini",
		},
	},
	keys = {
		{ "<leader>bf", "<cmd>FzfLua buffers<cr>", desc = "Find buffer" },
		{ "<leader>bs", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Search buffer" },
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find recent file" },
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find file" },
		{ "<leader>fs", "<cmd>FzfLua live_grep<cr>", desc = "Search files" },
		{ "<F1>", "<cmd>FzfLua helptags<cr>", desc = "Find help", mode = { "n", "i" } },
	},
}
