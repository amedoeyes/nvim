local util = require("config.util")

local map = vim.keymap.set

--Buffers

map("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", { desc = "Delete non-pinned buffers" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Pin buffer" })

map("n", "<leader>bs", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search buffer" })

map("n", "<leader>bd", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

--Code

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

map("i", "<tab>", function()
	if require("luasnip").jumpable(1) then
		return "<Plug>luasnip-jump-next"
	end

	if string.find(vim.fn["codeium#GetStatusString"](), "/") then
		return vim.fn["codeium#Accept"]()
	end

	return "<tab>"
end, { desc = "Luasnip/Codeium/Tab", expr = true, silent = true })

map("s", "<tab>", function()
	require("luasnip").jump(1)
end, { desc = "Next snippet" })

map({ "i", "s" }, "<s-tab>", function()
	require("luasnip").jump(-1)
end, { desc = "Previous snippet" })

map("n", "<leader>cs", "<cmd> Telescope spell_suggest<cr>", { desc = "Spell suggestions" })

--Debugger

map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP condition breakpoint" })

map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "DAP toggle breakpoint" })

map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "DAP continue" })

map("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "DAP run to cursor" })

map("n", "<leader>dg", function()
	require("dap").goto_()
end, { desc = "DAP goto" })

map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "DAP step into" })

map("n", "<leader>dj", function()
	require("dap").down()
end, { desc = "DAP down" })

map("n", "<leader>dk", function()
	require("dap").up()
end, { desc = "DAP up" })

map("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "DAP run last" })

map("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "DAP step out" })

map("n", "<leader>dO", function()
	require("dap").step_over()
end, { desc = "DAP step over" })

map("n", "<leader>dp", function()
	require("dap").pause()
end, { desc = "DAP pause" })

map("n", "<leader>dr", function()
	require("dap").repl.toggle()
end, { desc = "DAP toggle REPL" })

map("n", "<leader>ds", function()
	require("dap").session()
end, { desc = "DAP session" })

map("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "DAP terminate" })

map("n", "<leader>dw", function()
	require("dap.ui.widgets").hover()
end, { desc = "DAP widgets" })

map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "DAP UI" })

--Files

map("n", "<leader>fe", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
end, { desc = "Files explorer" })

map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Search files" })
map("n", "<leader>fp", "<Cmd>Telescope projects<CR>", { desc = "Projects" })

--Git

map("n", "<leader>gg", function()
	local Terminal = require("toggleterm.terminal").Terminal

	local lazygit = Terminal:new({
		cmd = "lazygit",
		direction = "float",
		dir = vim.fn.getcwd(),
	})

	lazygit:toggle()
end, { desc = "lazygit" })

--LSP

util.lsp.on_attach(function(_, buffer)
	--Code

	map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = buffer })
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = buffer })
	map({ "n", "v" }, "<leader>cf", util.lsp.format, { desc = "Format", buffer = buffer })

	--Diagnostics

	map("n", "<leader>xs", "<cmd>Telescope diagnostics<cr>", { desc = "Search diagnostics", buffer = buffer })
	map("n", "<leader>xx", vim.diagnostic.open_float, { desc = "Diagnostic", buffer = buffer })

	map(
		"n",
		"<leader>xd",
		"<cmd>TroubleToggle document_diagnostics<cr>",
		{ desc = "Document diagnostics", buffer = buffer }
	)

	map(
		"n",
		"<leader>xw",
		"<cmd>TroubleToggle workspace_diagnostics<cr>",
		{ desc = "Workspace diagnostics", buffer = buffer }
	)

	map("n", "]q", function()
		require("trouble").next({ skip_groups = true, jump = true })
	end, { desc = "Next quickfix", buffer = buffer })

	map("n", "[q", function()
		require("trouble").previous({ skip_groups = true, jump = true })
	end, { desc = "Previous quickfix", buffer = buffer })

	--Documentation

	map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation", buffer = buffer })

	--Go to

	map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = buffer })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = buffer })
	map("n", "gr", require("telescope.builtin").lsp_references, { desc = "Go to references", buffer = buffer })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = buffer })
	map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = buffer })

	--Options

	map("n", "<leader>of", function()
		util.toggle(util.lsp.config.autoformat, "Autoformat", function(val)
			util.lsp.config.autoformat = val
		end)
	end, { desc = "Toggle autoformat", buffer = buffer })

	map("n", "<leader>oi", function()
		util.toggle(util.lsp.config.inlay_hint, "Inlay hint", function(val)
			util.lsp.config.inlay_hint = val
			vim.lsp.inlay_hint(0, val)
		end)
	end, { desc = "Toggle inlay hint", buffer = buffer })
end)

--Movement

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Next line", expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Previous line", expr = true, silent = true })

--Options

map("n", "<leader>os", function()
	util.toggle(vim.o.spell, "Spell", function(val)
		vim.o.spell = val
	end)
end, { desc = "Toggle spell" })

map("n", "<leader>oc", function()
	util.toggle(vim.g.codeium_enabled, "Codeium", function(val)
		vim.g.codeium_enabled = val
	end)
end, { desc = "Toggle Codeium" })

--Search

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })

map("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Search autocommands" })
map("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Search commands" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search help" })
map("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search highlights" })
map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search keymaps" })
map("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Search options" })

map("n", "s", function()
	require("flash").jump()
end, { desc = "Flash jump" })

map("n", "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })

map("n", "]r", function()
	require("illuminate").goto_next_reference()
end, { desc = "Next reference" })

map("n", "[r", function()
	require("illuminate").goto_prev_reference()
end, { desc = "Previous reference" })

--Sessions

map("n", "<leader>qr", function()
	require("persistence").load()
end, { desc = "Restore session" })

map("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { desc = "Restore last session" })

map("n", "<leader>qd", function()
	require("persistence").stop()
end, { desc = "Don't save session" })

--Terminal

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

map({ "n", "t" }, "<C-`>", function()
	require("toggleterm").toggle(1, 15, vim.fn.getcwd(), "horizontal")
end, { desc = "Toggle terminal" })

map("n", "<leader>th", function()
	require("toggleterm").toggle(1, 15, vim.fn.getcwd(), "horizontal")
end, { desc = "Open horizontal terminal" })

map("n", "<leader>tv", function()
	require("toggleterm").toggle(1, 75, vim.fn.getcwd(), "vertical")
end, { desc = "Open vertical terminal" })

map("n", "<leader>tf", function()
	require("toggleterm").toggle(1, 0, vim.fn.getcwd(), "float")
end, { desc = "Open floating terminal" })

--Windows

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

--UI

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect" })

map("n", "<leader>un", function()
	util.require("notify").dismiss({ silent = true, pending = true })
end, { desc = "Dismiss notifications" })

map("n", "<leader>uN", "<cmd>Telescope notify<cr>", { desc = "Notifications history" })
