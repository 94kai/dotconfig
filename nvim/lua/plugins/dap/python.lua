local dap = require("dap")
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}
local function get_arguments()
  return coroutine.create(function(dap_run_co)
    local args = {}
    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
      coroutine.resume(dap_run_co, args)
    end)
  end)
end
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Debug",
    program = "${file}",
    pythonPath = function()
      return "python"
    end,
  },
  {
    type = "python",
    request = "launch",
    name = "Debug (Arguments)",
    program = "${file}",
    args = get_arguments,
    pythonPath = function()
      return "python"
    end,
  },
}
