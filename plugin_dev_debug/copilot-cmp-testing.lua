local config = function()
  local requester = require("copilot.constant_request")
  local request_dispatcher = requester:new()
  request_dispatcher:start()
  require("copilot_cmp").setup({
    custom_completion_function = function(self, params, callback)
      print("here")
      local completions = request_dispatcher:get_current_completions()
      if completions and not vim.tbl_isempty(completions) then
        vim.schedule(function() callback(completions) end)
      else callback({})
      end
    end
  })
end
