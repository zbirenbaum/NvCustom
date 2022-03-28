local oldprint = print
local print = function(o)
  oldprint(vim.inspect(o))
end

local format_content = function (json_body)
   return "Content-Length: " .. string.len(json_body) .. '\r\n\r\n' .. json_body
end

local initialize = function (instance)
   local request = '{"method": "initialize", "jsonrpc": "2.0", "id": 1, "params": {"capabilities": {}}}'
   print(format_content(request))
   instance.job:send(format_content(request))
end

local set_editor_info = function (instance)
   -- local request = '{"method": "setEditorInfo", "jsonrpc": "2.0", "id": 2, "params": {"editorPluginInfo": {"version": "1.1.0", "name": "copilot.vim"}, "editorInfo": {"version": "0.7.0-dev+1337-g72652cbc4-dirty", "name": "Neovim"}}}' instance.job:send(format_content(request))
end


local agent = require("custom.utils.copilot.agent")
local a = agent:start()
a:start_loop()
a.instance.job:start()
a:queue_request("initialize", {capabilities = {}})
a:queue_request("setEditorInfo", {
   editorPluginInfo = {
      version = "1.1.0",
      name = "copilot.vim"
   },
   editorInfo = {
      version = "0.7.0-dev+1337-g72652cbc4-dirty",
      name = "Neovim"
   }
})





