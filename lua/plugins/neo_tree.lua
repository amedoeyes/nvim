return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "main",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("neotree_start_directory", { clear = true }),
			once = true,
			callback = function()
				if not package.loaded["neo-tree"] then
					---@diagnostic disable-next-line: param-type-mismatch
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then require("neo-tree") end
				end
			end,
		})
	end,
	opts = function()
		local utils = require("core.utils")
		local events = require("neo-tree.events")
		return {
			close_if_last_window = true,
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			window = {
				mappings = {
					["<space>"] = "none",
					["Y"] = {
						function(state) vim.fn.setreg("+", state.tree:get_node():get_id(), "c") end,
						desc = "copy path to clipboard",
					},
					["O"] = {
						function(state) vim.ui.open(state.tree:get_node().path) end,
						desc = "open with system application",
					},
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				indent = { with_expanders = true },
			},
			event_handlers = {
				{
					event = events.FILE_MOVED,
					handler = function(args) utils.lsp.rename_file(args.source, args.destination) end,
				},
				{
					event = events.FILE_RENAMED,
					handler = function(args) utils.lsp.rename_file(args.source, args.destination) end,
				},
				{
					event = events.NEO_TREE_POPUP_INPUT_READY,
					handler = function(args)
						vim.keymap.set("i", "<esc>", vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
					end,
				},
			},
		}
	end,
	config = function(_, opts)
		require("neo-tree").setup(opts)
		vim.api.nvim_create_autocmd("TermClose", {
			group = vim.api.nvim_create_augroup("lazygit_close", { clear = true }),
			pattern = "*lazygit*",
			callback = function() require("neo-tree.sources.git_status").refresh() end,
		})
	end,
	keys = {
		{
			"<leader>ft",
			function() require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() }) end,
			desc = "File tree",
		},
	},
}
