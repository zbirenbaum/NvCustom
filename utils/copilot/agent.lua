local copilot_job = require("custom.utils.copilot.job")
local agent = {}
agent.__index = agent

function agent:get_results ()
   -- local results = self.instance.job:result()
   local results = self.instance.job:result()
   if results and not vim.tbl_isempty(results) then
      print("Recieved result for ID: " .. self.instance.current_request_id)
      for k, v in pairs(results) do
         print("key" .. k)
         print("value" .. v)
      end
      io.flush()
      -- self.instance.job:_reset()
      return results[self.instance.current_request_id]
   end
end


local format_content = function (json_body)
   return "Content-Length: " .. string.len(json_body) .. '\r\n\r\n' .. json_body
end

function agent:build_request (method, id, params)
   local request = {method = method, id = id, params=params}
   request.jsonrpc = "2.0"
   return request
end

function agent:send_request(request)
   assert(self.instance.current_request_id == request.id, "Request id mismatch")
   local request_json = format_content(vim.fn.json_encode(request))
   self.instance.job:send(request_json)
end

function agent:set_capabilities(result)
   self.instance.capabilities = vim.fn.json_decode(result[3]).result.capabilities
end

function agent:start_loop()
   local instance = self.instance
   instance.timer = vim.loop.new_timer()
   local sleep = instance.job_debounce.sleep
   instance.timer:start(1000, sleep, vim.schedule_wrap(function()
      if instance.current_request_id == nil then
         local new_request = instance.requests[1].request
         instance.current_request_id = new_request.id
         self:send_request(new_request)
         return
      end

      if instance.current_request_id > #instance.requests then
         return
      end
      local current_req_results = self:get_results()
      if current_req_results then
         instance.requests[instance.current_request_id].result = current_req_results
         instance.current_request_id = instance.current_request_id + 1
         if instance.current_request_id > #instance.requests then
            return
         end
         self:send_request(instance.requests[instance.current_request_id].request)
      end
      self.instance = instance
   end))
end


function agent:queue_request(method, params)
   local id = #self.instance.requests + 1
   local request = self:build_request(method,id, params)
   self.instance.requests[id] = {
      request = request,
      type = method,
      id = id,
      status = "queued",
      response = nil
   }
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
      current_request_id = nil,
      close = agent_close,
      notify = agent_notify,
      request = agent_request,
      call = agent_call,
      cancel = agent_cancel,
      capabilities = {}
   }
   self.job_status = {}
   self.state = {headers = {}, mode = 'headers', buffer = ''}
   self.instance.job = copilot_job.new(self.command, job_status)
   self.instance.job_debounce = {sleep = 1000, timer = nil}
   return self
end

function agent:start()
   if not self.instance or not self.instance.job then
      return agent:new()
   end
end

return agent
