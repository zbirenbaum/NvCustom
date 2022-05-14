local opts = { noremap = true, silent = true }
local maps = vim.keymap.set
local M = {}

M.tab = function ()
  vim.keymap.set({"i", "n", "t", "v"}, '<C-i>', '<tab>', {silent=true, remap=true})
end
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

M.terminal_mappings = function ()
  local ft_cmds = {
    python = "python3 " .. vim.fn.expand('%'),
  }
  local toggle_modes = {'n', 't'}
  local mappings = {
    { 'n', '<C-l>', function () require("nvterm.terminal").send(ft_cmds[vim.bo.filetype]) end },
    { toggle_modes, '<A-h>', function () require("nvterm.terminal").toggle('horizontal') end },
    { toggle_modes, '<A-v>', function () require("nvterm.terminal").toggle('vertical') end },
    { toggle_modes, '<A-i>', function () require("nvterm.terminal").toggle('float') end },
  }
  return mappings
end

M.terminal = function()
  maps("t", "<esc>", [[<C-\><C-n>]], opts)
  maps("t", "jk", "<esc>", opts)
  maps("t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
  maps("t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
  maps("t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
  maps("t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
  local mappings = M.terminal_mappings()
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
  end
end

return M
