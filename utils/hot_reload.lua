local function on_write_init()
  local filename = vim.api.nvim_buf_get_name(0)
  local cmdstr = "luafile " .. filename
  if string.match(filename, "lua/plugins/init.lua") then
    vim.cmd(cmdstr)
  else
    local userfile = require("core.utils").load_config().plugins.install
    local usermatch = type(userfile) == "string" and string.match(filename, userfile)
    if usermatch or string.match(filename, "lua/plugins/init.lua") then
      vim.cmd(cmdstr)
    end
  end
end
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
  callback = on_write_init,
  once = false,
})
