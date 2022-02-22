
local opts = { noremap = true, silent = true }
local M = {}
M.navigation = function ()
   vim.cmd [[ 
   au VimEnter * lua 
   \ vim.keymap.set('n', '<C-l>', '$', {silent=true, noremap=true})
   \ vim.keymap.set('n', '<C-h>', '^', {silent=true, noremap=true})
   \ vim.keymap.set('c', '<C-c>', '<C-e>', {silent=true, noremap=true}) 
   ]]
end

M.debug = function ()
   local dap = function ()
      vim.keymap.set('n', '<C-b>', function () require("dap").toggle_breakpoint() end, opts)
      vim.keymap.set('n', '<Leader>r', function () require("dap").repl.toggle() end, opts)
      vim.keymap.set('n', '<Leader>d', function () require("dapui").toggle() end, opts)
      vim.keymap.set('n', '<C-o>', function () require("dap").step_out() end, opts)
      vim.keymap.set('n', '<C-n>', function () require("dap").step_into() end, opts)
      vim.keymap.set('n', '<C-c>',
      function()
         if vim.bo.filetype == "lua" and not require("dap").session() then
            require("osv").run_this()
         else
            require("dap").continue()
         end
      end, opts)
   end
   local nvim_gdb = function ()
   end
   if vim.bo.filetype ~= "cpp" and vim.bo.filetype ~= "c" and vim.bo.filetype ~= "cuda" then
      dap()
   else
      nvim_gdb()
   end
   vim.keymap.set('n', "<leader>t", function ()
      vim.cmd[[TroubleToggle]]
   end, opts)
end

M.terminal = function ()
   vim.keymap.set('t', "<esc>", [[<C-\><C-n>]], opts)
   vim.keymap.set('t', "jk", "<esc>", opts)
   vim.keymap.set('t', "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
   vim.keymap.set('t', "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
   vim.keymap.set('t', "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
   vim.keymap.set('t', "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
end

return M

-- vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "$", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "^", opts)
--vim.api.nvim_buf_set_keymap(0, "n", "<C-w>b", "<CMD>terminal w3m www.duckduckgo.com<CR>",opts)
