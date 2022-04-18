local cmdmap = {
  lua = "luafile %",
  python = "python3 " .. vim.fn.expand('%'),
}

vim.keymap.set({"i", "n"}, "<C-a>", function()
  require("custom.plugin_dev_debug.term_exec").run(cmdmap[vim.bo.filetype])
end, { noremap = true, silent = true })
