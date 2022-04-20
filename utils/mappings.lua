local opts = { noremap = true, silent = true }
local maps = vim.keymap.set
local M = {}

local choose_debug_session = function ()
  if vim.bo.filetype == "lua" and not require("dap").session() then require("osv").run_this()
  else require("dap").continue() end
end

M.debug_bindings = {
  mappings = {
    { 'n', "<C-b>" },
    { 'n', "<C-o>" },
    { 'n', "<C-O>" },
    { 'n', "<C-n>" },
    { 'n', "<Leader>r" },
    { 'n', "<Leader>c" },
  },
  callbacks = {
    function () require("dap").toggle_breakpoint() end,
    function () require("dap").step_over() end,
    function () require("dap").step_out() end,
    function () require("dap").step_into() end,
    function () require("dap").repl.toggle() end,
    function () choose_debug_session() end
  }
}

M.debug = function()
  for index, mapping in pairs(M.debug_bindings.mappings) do
    maps(mapping[1], mapping[2], M.debug_bindings.callbacks[index], opts)
  end
  maps("n", "<leader>t", function()
    vim.cmd([[TroubleToggle]])
  end, opts)
end

M.terminal = function()
  maps("t", "<esc>", [[<C-\><C-n>]], opts)
  maps("t", "jk", "<esc>", opts)
  maps("t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  maps("t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  maps("t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  maps("t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
  maps("n", "<C-l>", function()
    require("custom.plugin_dev_debug.print_to_buf").runfile()
  end, opts)
end

return M
