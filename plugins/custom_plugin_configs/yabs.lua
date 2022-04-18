local yabs = require('yabs')
local gen_nested = function(run) return {tasks={['run']=run}} end

yabs:setup({
  languages = {
    lua = gen_nested({command = 'luafile %', type = 'vim'}),
    python = gen_nested({command='python3 ' .. vim.fn.expand('%'),type='shell',output='consolation'}),
  },
})


vim.keymap.set({"i", "n"}, "<C-n>", function()
  yabs:run_default_task()
end)
