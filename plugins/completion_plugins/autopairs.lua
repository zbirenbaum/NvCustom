local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

autopairs.setup({ fast_wrap = {} })

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
