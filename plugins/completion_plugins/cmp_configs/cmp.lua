-- require('copilot.copilot-cmp.setup').setup()

require('copilot_cmp').setup()
local present, cmp = pcall(require, "cmp")

local lspkind = require("custom.plugins.completion_plugins.cmp_configs.lspkind")
if not present then
   return
end

vim.opt.completeopt = "menuone,noselect"
cmp.setup {
   snippet = {expand = function(args) require("luasnip").lsp_expand(args.body) end},
   style = {
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
   },
   formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
   },
   window = {
      completion = {
         border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
         scrollbar = '║',
         autocomplete = {
            require('cmp.types').cmp.TriggerEvent.InsertEnter,
            require('cmp.types').cmp.TriggerEvent.TextChanged,
         },
      },
      documentation = {
         border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
         winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
         scrollbar = '║',
      },
   },
   mapping = {
      ["<PageUp>"] = function()
         for _ = 1, 10 do
            cmp.mapping.select_prev_item()(nil)
         end
      end,
      ["<PageDown>"] = function()
         for _ = 1, 10 do
            cmp.mapping.select_next_item()(nil)
         end
      end,
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = false,
      },
      ['<Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
         else
            fallback()
         end
      end,
      ['<S-Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
         else
            fallback()
         end
      end,
   },
   experimental = {
      native_menu = false,
      ghost_text = true,
   },
   sources = {
      { name = "copilot", group_index = 1},
      { name = "nvim_lsp", group_index = 3},
      { name = "path", group_index = 2},
      -- { name = "luasnip", group_index = 2 },
      -- { name = "buffer", group_index = 5 },
      { name = "nvim_lua", group_index = 4 },
   },
   sorting = {
      comparators = {
         cmp.config.compare.recently_used,
         cmp.config.compare.offset,
         cmp.config.compare.score,
         cmp.config.compare.sort_text,
         cmp.config.compare.length,
         cmp.config.compare.order,
      },
   },
   preselect = cmp.PreselectMode.Item,
}
--set max height of items
vim.cmd [[ set pumheight=6 ]]
--set highlights
local highlights = {
   CmpItemKindText = {fg="LightGrey"},
   CmpItemKindFunction = {fg="#C586C0"},
   CmpItemKindClass = {fg="Orange"},
   CmpItemKindKeyword = {fg="#f90c71"},
   CmpItemKindSnippet = {fg="#565c64"},
   CmpItemKindConstructor = {fg="#ae43f0"},
   CmpItemKindVariable = {fg="#9CDCFE", bg="NONE"},
   CmpItemKindInterface ={fg="#f90c71", bg="NONE"},
   CmpItemKindFolder = {fg="#2986cc"},
   CmpItemKindReference = {fg="#922b21"},
   CmpItemKindMethod = {fg="#C586C0"},
   CmpItemMenu = {fg="#C586C0", bg="#C586C0"},
   CmpItemAbbr = {fg="#565c64", bg="NONE"},
   CmpItemAbbrMatch = {fg="#569CD6", bg="NONE"},
   CmpItemAbbrMatchFuzzy = {fg="#569CD6", bg="NONE"},
}
vim.api.nvim_set_hl(0, 'CmpBorderedWindow_FloatBorder', {fg='#565c64'})
for group, hl in pairs(highlights) do
   vim.api.nvim_set_hl(0, group, hl)
end

