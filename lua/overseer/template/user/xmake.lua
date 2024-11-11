local constants = require("overseer.constants")
local json = require("overseer.json")
local log = require("overseer.log")
local overseer = require("overseer")
local TAG = constants.TAG

local function get_xmake_file(opts)
	return vim.fs.find("xmake.lua", { upward = true, type = "file", path = opts.dir })[1]
end

local function get_targets(cwd, cb)
	local jid = vim.fn.jobstart({ "xmake", "show", "-l", "targets", "--json" }, {
		cwd = cwd,
		stdout_buffered = true,
		on_stdout = vim.schedule_wrap(function(_, output)
			local ok, targets = pcall(json.decode, table.concat(output, ""))
			if ok then
				cb(nil, targets)
			end
		end),
	})
	if jid == 0 then
		cb("Passed invalid arguments to 'xmake'")
	elseif jid == -1 then
		log:error("'xmake' is not executable")
		cb("'xmake' is not executable")
	end
end

return {
	cache_key = function(opts)
		return get_xmake_file(opts)
	end,
	condition = {
		callback = function(opts)
			if vim.fn.executable("xmake") == 0 then
				return false, 'Command "xmake" not found'
			end
			if not get_xmake_file(opts) then
				return false, "No xmake.lua file found"
			end
			return true
		end,
	},
	generator = function(opts, cb)
		local ret = {}
		local cwd = vim.fs.dirname(assert(get_xmake_file(opts)))
		get_targets(cwd, function(err, targets)
			if err then
				cb(ret)
				return
			end
			local tmpl = {
				priority = 60,
				params = {
					args = { optional = true, type = "list", delimiter = " ", default = {} },
					target = { optional = true, type = "enum", choices = targets },
				},
				builder = function(params)
					return {
						cmd = "xmake",
						args = { table.concat(params.args, " "), params.target },
						cwd = cwd,
					}
				end,
			}
			local commands = {
				{ args = {}, tags = { TAG.BUILD } },
				{ args = { "build" }, tags = { TAG.BUILD } },
				{ args = { "run" }, tags = { TAG.RUN } },
				{ args = { "clean" }, tags = { TAG.CLEAN } },
			}
			for _, command in ipairs(commands) do
				table.insert(
					ret,
					overseer.wrap_template(tmpl, {
						name = string.format("xmake %s", table.concat(command.args, " ")),
						tags = command.tags,
					}, {
						args = command.args,
					})
				)
			end
			cb(ret)
		end)
	end,
}
