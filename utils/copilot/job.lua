local plen_job = require('plenary.job')
local M = {}

M.new = function(command, agent_job_status)
   vim.api.nvim_buf_set_var(0, 'plen_job_status', agent_job_status)
   local user_data = require("custom.utils.copilot.setup").get_cred()
   local args = {
      command = command,
      enable_handlers= true,
      enable_recording = true,
      env = {
         ["GITHUB_USER"] = user_data.user,
         ["GITHUB_TOKEN"] = user_data.token,
      },
      -- on_start = function()
      --    agent_job_status.status = 'started'
      --    print("started")
      -- end,
      -- on_stdout = function(out)
      --    agent_job_status.out = out
      --    print("out")
      -- end,
      on_stderr = function(err, code)
         agent_job_status.err = {err, code}
         print("err")
         print(vim.inspect(err))
      end,
      on_exit = function(code)
         agent_job_status.status = 'exited'
         print("exited: " .. code)
      end
   }
   local job = plen_job:new(args)
   return job
end

return M
