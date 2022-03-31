local lsp_setup = require("custom.plugins.lsp_plugins.nvim_lsp_setup")
local user_data = require("custom.utils.copilot.setup").get_cred()
local capabilities = lsp_setup.setup_capabilities()
capabilities.getCompletions = true

local format_pos = function()
   local pos = vim.api.nvim_win_get_cursor(0)
   return { character = pos[2], line = pos[1] }
end

local get_relfile = function()
   local file,_= string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd() .. "/", '')
   return file
end

local function completion_handler(_, result, c, _)
   print(vim.inspect(result.completions))
end

local get_completions = function()
   local params = {
      options = vim.empty_dict(),
      doc = {
         relativePath = get_relfile(),
         source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n'),
         languageId = vim.bo.filetype,
         insertSpaces = true,
         tabsize = vim.bo.shiftwidth,
         indentsize = vim.bo.shiftwidth,
         position = format_pos(),
         path = vim.api.nvim_buf_get_name(0),
      }
   }
   completions = vim.lsp.buf_request(0, 'getCompletions', params, completion_handler)
   print(vim.inspect(vim.lsp.buf_request_sync(0, 'getCompletions', params, 600)))
end
local send_editor_info = function (a, b, c, d)
   local responses = vim.lsp.buf_request_sync(0, 'setEditorInfo', {
      editorPluginInfo = {
         name = 'copilot.vim',
         version = '1.1.0',
      },
      editorInfo= {
         version = '0.7.0-dev+1343-g4d3acd6be-dirty',
         name = "Neovim",
      },
   }, 600)
   print(vim.inspect(responses))
end

-- local initialize = function ()
--    local params = {capabilities = vim.empty_dict()}
--    vim.lsp.buf_request(0, 'initialize', params, initialize_handler)
-- end

vim.lsp.start_client({
   cmd = {"/home/zach/.config/nvim/lua/custom/utils/copilot/index.js"},
   cmd_env = {
      ["GITHUB_USER"] = user_data.user,
      ["GITHUB_TOKEN"] = user_data.token,
      ["COPILOT_AGENT_VERBOSE"] = 1,
   },
   handlers={
      ["getCompletions"] = function () print("get completions") end,
      ["textDocumentSync"] = function () print("handle") end,
   },
   name = "copilot",
   trace = "messages",
   root_dir = vim.loop.cwd(),
   autostart = true,
   on_init = function(client, _)
      vim.lsp.buf_attach_client(0, client.id)
   end,
   on_attach = function()
      send_editor_info()
      vim.keymap.set('n', '<leader>i', get_completions, {noremap = true, silent = true})
      vim.api.nvim_create_autocmd({'TextChangedI'}, {
         callback = get_completions,
         once = false,
      })
   end
})
