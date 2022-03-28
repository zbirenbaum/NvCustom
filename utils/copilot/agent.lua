local agent = {}
agent.__index = agent


local format_content = function (json_body)
   return "Content-Length: " .. string.len(json_body) .. '\r\n\r\n' .. json_body
end

function agent:build_request (method, id, params)
   local request = {method = method, id = id, params=params}
   request.jsonrpc = "2.0"
   return request
end

function agent:send_request(request)
   self.instance.current_request_id = request.id
   local request_json = format_content(vim.fn.json_encode(request))
   self.instance.job:send(request_json)
end

function agent:get_next()
   local next_idx = self.instance.requests.in_queue.first
   local new_request = self.instance.requests.in_queue.list[next_idx].request
   return new_request
end

function agent:has_next()
   return #self.instance.requests.in_queue.list > 0
end


function agent:move_to_completed(id, result)
   local in_queue = self.instance.requests.in_queue
   self.instance.requests.completed[id] = in_queue:popleft()
   self.instance.requests.completed[id].result = result
   self.instance.requests.completed[id].status = "completed"
end

function agent:set_capabilities(result)
   self.instance.capabilities = vim.fn.json_decode(result[3]).result.capabilities
end
function agent:loop_body (id, result)
   local instance = self.instance
   if result and not vim.tbl_isempty(result) then
      print(vim.inspect(result))
      if not instance.requests.completed[id] then
         self:move_to_completed(id, result)
         if self.instance.requests.completed[id].type == "initialize" then
            self:set_capabilities(result)
         end
         self.instance.current_request_id = self.instance.current_request_id + 1
      end
      if self:has_next() then
         local new_request = self:get_next()
         self:send_request(new_request)
      end
   end
   result = nil
   print(self.instance.current_request_id)
end

function agent:start_loop()
   local instance = self.instance
   instance.timer = vim.loop.new_timer()
   local sleep = instance.job_debounce.sleep
   instance.timer:start(1000, sleep, vim.schedule_wrap(function()
      local id = instance.current_request_id
      local result = instance.job:result()
      if instance.current_request_id == nil and self:has_next() then
         self:send_request(self:get_next())
         return
      end
      self:loop_body(id, result)
   end))
end


function agent:queue_request(method, params)
   local id = #self.instance.requests.all + 1
   local request = self:build_request(method,id, params)
   self.instance.requests.all[id] = request
   self.instance.requests.in_queue:pushright({
      request = request,
      type = method,
      id = id,
      status = "queued",
      response = nil
   })
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
      requests = {
         all = {},
         in_queue = require("custom.utils.copilot.queue"):new(),
         completed = {}
      },
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
