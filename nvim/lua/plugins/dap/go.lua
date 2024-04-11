local dap = require('dap')
dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	}
}
local function filtered_pick_process()
	local opts = {}
	vim.ui.input(
		{ prompt = "Search by process name (lua pattern), or hit enter to select from the process list: " },
		function(input)
			opts["filter"] = input or ""
		end
	)
	return require("dap.utils").pick_process(opts)
end
local function get_arguments()
	return coroutine.create(function(dap_run_co)
		local args = {}
		vim.ui.input({ prompt = "Args: " }, function(input)
			args = vim.split(input or "", " ")
			coroutine.resume(dap_run_co, args)
		end)
	end)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug (Arguments)",
		request = "launch",
		program = "${fileDirname}",
		args = get_arguments,
		buildFlags = "",
	},
	{
		type = "delve",
		name = "Debug Package",
		request = "launch",
		program = "${fileDirname}",
		buildFlags = "",
	},
	{
		type = "delve",
		name = "Attach",
		mode = "local",
		request = "attach",
		processId = filtered_pick_process,
		buildFlags = "",
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
		buildFlags = "",
	},
}
