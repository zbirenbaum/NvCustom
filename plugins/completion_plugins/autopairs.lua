local npairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
-- change default fast_wrap
npairs.setup()
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
--   filetypes = {
--     ['*'] = {
--       ['('] = {
--         kind = {
--           cmp.lsp.CompletionItemKind.Function,
--           cmp.lsp.CompletionItemKind.Method,
--         },
--       }
--     }
--   }
-- }))
