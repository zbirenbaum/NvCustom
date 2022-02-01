local M = {}
M.navigation = function ()
   vim.cmd [[ 
      au VimEnter * lua
         \ vim.keymap.set('n', '<C-l>', '$', {silent=true, noremap=true})
         \ vim.keymap.set('n', '<C-h>', '^', {silent=true, noremap=true})
         \ vim.keymap.set('c', '<C-c>', '<C-e>', {silent=true, noremap=true}) 
   ]]
end

M.dap = function ()
  vim.keymap.set('n', '<C-b>', function () require("dap").toggle_breakpoint() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<Leader>r', function () require("dap").repl.toggle() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<Leader>d', function () require("dapui").toggle() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-o>', function () require("dap").step_out() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-n>', function () require("dap").step_into() end, {silent=true, noremap=true})
  vim.keymap.set('n', '<C-c>',
    function()
      if vim.bo.filetype == "lua" and not require("dap").session() then
        require("osv").run_this()
      else
        require("dap").continue()
      end
    end,
    {silent=true, noremap=true})
end

M.terminal = function ()
   local opts = { noremap = true }
   vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
   vim.api.nvim_buf_set_keymap(0, "t", "jk", "<esc>", opts)
   vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
   vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
   vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
   vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
end

return M

-- vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", "$", opts)
-- vim.api.nvim_buf_set_keymap(0, "n", "<C-h>", "^", opts)
--vim.api.nvim_buf_set_keymap(0, "n", "<C-w>b", "<CMD>terminal w3m www.duckduckgo.com<CR>",opts)
