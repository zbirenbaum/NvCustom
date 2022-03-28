local oldprint = print
local print = function(o)
  oldprint(vim.inspect(o))
end


local agent = require("custom.utils.copilot.agent")
local a = agent:start()
a:start_loop()
a.instance.job:start()
print(a.instance.job.pid)
-- vim.fn.json_encode({
--    jsonrpc = "2.0",
--    method = "initialize",
--    params = {
--       capabilities = {}
--    }
-- }))
