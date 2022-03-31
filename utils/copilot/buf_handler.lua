local lsp_setup = require("custom.plugins.lsp_plugins.nvim_lsp_setup")
local user_data = require("custom.utils.copilot.setup").get_cred()
-- local capabilities = lsp_setup.setup_capabilities()
local lsp_util = require("custom.utils.copilot.lsp_util")

-- capabilities.getCompletions = true


local function completion_handler(_, result, c, _)
   print(vim.inspect(result.completions))
end

local get_completions = function() local params = lsp_util.get_completion_params()
   completions = vim.lsp.buf_request(0, 'getCompletions', params, completion_handler)
end

vim.lsp.start_client({
   cmd = {"/home/zach/.config/nvim/lua/custom/utils/copilot/index.js"},
   cmd_env = {
      ["GITHUB_USER"] = user_data.user,
      ["GITHUB_TOKEN"] = user_data.token,
      ["COPILOT_AGENT_VERBOSE"] = 1,
   },
   name = "copilot",
   trace = "messages",
   root_dir = vim.loop.cwd(),
   autostart = true,
   on_init = function(client, _)
      vim.lsp.buf_attach_client(0, client.id)
   end,
   on_attach = function()
      vim.api.nvim_create_autocmd({'TextChangedI'}, {
         callback = get_completions,
         once = false,
      })
   end
})
