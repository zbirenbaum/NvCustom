local agent = {}
agent.__index = agent

function agent:http_request (url, options)
   local body = vim.fn.json_encode({method='httpRequest', url = url, options = options})
   self.instance.job:send(body)
end
function agent:get_requests()
   return self.instance.requests
end
function agent:start_loop()
   self.instance.timer = vim.loop.new_timer()
   self.instance.timer:start(1000, self.instance.job_debounce.sleep, vim.schedule_wrap(function()
      -- print(vim.inspect(self.instance.job:result()))
      -- print(vim.inspect(self.instance.job:stderr_result()))
      local result = self.instance.job:result()
      if result and not vim.tbl_isempty(result) then
         print(vim.inspect(result))
      end
   end))
end
local function agent_close()
end

local function agent_notify()
end

local function agent_request()
end

local function agent_call()
end

local function agent_cancel()
end

local function nvim_callback(result)
end

local function nvim_exit_callback(result)
end
function agent:new ()
   local instance = {}
   local command = {}
   local state = {}
   local job_status = {}
   setmetatable(instance, self.instance)
   setmetatable(command, self.command)
   setmetatable(state, self.state)
   setmetatable(job_status, self.job_status)
   self.command = "/home/zach/.config/nvim/lua/custom/utils/copilot/index.js"
   self.instance = {
      requests = {},
      close = agent_close,
      notify = agent_notify,
      request = agent_request,
      call = agent_call,
      cancel = agent_cancel,
   }
   self.job_status = {}
   self.state = {headers = {}, mode = 'headers', buffer = ''}
   self.instance.job = require("custom.utils.copilot.job").new(self.command, job_status)
   self.instance.job_debounce = {sleep = 1000, timer = nil}
   return self
end

function agent:start()
   if not self.instance or not self.instance.job then
      return agent:new()
   end
end

return agent
