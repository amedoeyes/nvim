return {
	"rebelot/heirline.nvim",
	lazy = false,
	opts = function()
		local utils = require("heirline.utils")

		local padding = function(size)
			return { provider = string.rep(" ", size) }
		end

		local vim_mode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = "NOR",
					no = "ONR",
					nov = "ONR",
					noV = "ONR",
					["no\22"] = "ONR",
					niI = "NOR",
					niR = "NOR",
					niV = "NOR",
					nt = "NOR",
					v = "VIS",
					vs = "VIS",
					V = "VLN",
					Vs = "VLN",
					["\22"] = "VBL",
					["\22s"] = "VBL",
					s = "SEL",
					S = "SLN",
					["\19"] = "SBL",
					i = "INS",
					ic = "INS",
					ix = "INS",
					R = "REP",
					Rc = "REP",
					Rx = "REP",
					Rv = "REP",
					Rvc = "REP",
					Rvx = "REP",
					c = "CMD",
					cv = "CMD",
					r = "PRM",
					rm = "MOR",
					["r?"] = "CNF",
					["!"] = "SHL",
					t = "TRM",
				},
			},
			provider = function(self)
				return self.mode_names[self.mode]
			end,
			hl = { bold = true },
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
			padding(2),
		}

		local git_branch = {
			condition = function()
				return vim.g.git_branch
			end,
			init = function(self)
				self.branch = vim.g.git_branch
			end,
			update = { "FocusGained" },
			provider = function(self)
				return " " .. self.branch
			end,
			padding(2),
		}

		local diagnostics = {
			condition = function()
				return #vim.diagnostic.get(0) > 0 and vim.diagnostic.is_enabled()
			end,
			static = (function()
				local icons = vim.diagnostic.config().signs.text
				return {
					error_icon = icons and icons[vim.diagnostic.severity.ERROR],
					warn_icon = icons and icons[vim.diagnostic.severity.WARN],
					info_icon = icons and icons[vim.diagnostic.severity.INFO],
					hint_icon = icons and icons[vim.diagnostic.severity.HINT],
				}
			end)(),
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				condition = function(self)
					return self.errors > 0
				end,
				provider = function(self)
					return self.error_icon .. self.errors
				end,
				padding(1),
			},
			{
				condition = function(self)
					return self.warnings > 0
				end,
				provider = function(self)
					return self.warn_icon .. self.warnings
				end,
				padding(1),
			},
			{
				condition = function(self)
					return self.info > 0
				end,
				provider = function(self)
					return self.info_icon .. self.info
				end,
				padding(1),
			},
			{
				condition = function(self)
					return self.hints > 0
				end,
				provider = function(self)
					return self.hint_icon .. self.hints
				end,
				padding(1),
			},
			padding(1),
		}

		local file = {
			init = function(self)
				self.filepath = vim.api.nvim_buf_get_name(0)
			end,
			{
				init = function(self)
					self.icon = require("nvim-web-devicons").get_icon_color(
						self.filepath,
						vim.fn.fnamemodify(self.filepath, ":e"),
						{ default = true }
					)
				end,
				provider = function(self)
					return self.icon and self.icon .. " "
				end,
			},
			{
				init = function(self)
					local filename = vim.fn.fnamemodify(self.filepath, ":.")
					self.filename = filename ~= "" and filename or "[No Name]"
				end,
				provider = function(self)
					return "%<" .. self.filename
				end,
			},
			padding(1),
			{
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = "●",
				},
				{
					condition = function()
						return not vim.bo.modifiable or vim.bo.readonly
					end,
					provider = "",
				},
			},
			padding(1),
		}

		local macro_rec = {
			condition = function()
				return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
			end,
			provider = function()
				return " recording @" .. vim.fn.reg_recording()
			end,
			update = { "RecordingEnter", "RecordingLeave" },
			padding(2),
		}

		local ruler = {
			provider = function()
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local status = curr_line == 1 and "TOP"
					or curr_line == lines and "BOT"
					or "%2(" .. math.floor((curr_line / lines) * 100) .. "%)%%"
				return "%" .. #tostring(lines) .. "l:%-3c " .. status
			end,
			hl = { bold = true },
		}

		local statusline = {
			padding(1),
			vim_mode,
			git_branch,
			diagnostics,
			file,
			{ provider = "%=" },
			macro_rec,
			ruler,
			padding(1),
		}

		local tabline = {
			padding(1),
			condition = function()
				return #vim.api.nvim_list_tabpages() >= 2
			end,
			utils.make_tablist({
				init = function(self)
					local wins = vim.api.nvim_tabpage_list_wins(self.tabpage)
					local buf = vim.api.nvim_win_get_buf(wins[1])
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
					self.filename = filename ~= "" and filename or "[No Name]"
				end,
				provider = function(self)
					return self.filename
				end,
				hl = function(self)
					if not self.is_active then
						return "TabLine"
					else
						return "TabLineSel"
					end
				end,
				padding(2),
			}),
			padding(1),
		}

		return {
			statusline = statusline,
			tabline = tabline,
		}
	end,
}
