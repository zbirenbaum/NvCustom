require('dap-python').setup("/home/zach/.virtualenvs/py3nvim/bin/python")
-- dap.adapters.python = {
--   type = 'executable';
--   command = "/home/zach/.virtualenvs/py3nvim/bin/python";
--   args = { '-m', 'debugpy.adapter' };
-- }
--
-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = 'launch';
--     name = "Launch file";
--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--     program = "${file}"; -- This configuration will launch the current file if used.
--     pythonPath = function()
--       if vim.env.VIRTUAL_ENV then return vim.env.VIRTUAL_ENV end
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       -- local cwd = vim.fn.getcwd()
--       -- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--       --   return cwd .. '/venv/bin/python'
--       -- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--       --   return cwd .. '/.venv/bin/python'
--       -- else
--       --   return '/usr/bin/python'
--       -- end
--     end;
--   },
-- }

local function dap_mappings()
   vim.api.nvim_set_keymap("n", "<Leader>d", '<Cmd>lua require"dapui".toggle()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-b>", '<Cmd>lua require"dap".toggle_breakpoint()<CR>', {
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-c>", '<Cmd>:lua require"dap".continue()<CR>',{
      silent = true,
      noremap = true,
   })
   vim.api.nvim_set_keymap("n", "<C-s>", '<Cmd>lua require"dap".step_into()<CR>', {
      silent = true,
      noremap = true,
   })
end

dap_mappings()
