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
         --winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
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
      { name = "nvim_lsp", group_index = 2},
      { name = "path", group_index = 2},
--      { name = "luasnip", group_index = 2 },
--      { name = "buffer", group_index = 3 },
      { name = "nvim_lua", group_index = 1 },
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

--lsp kind
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
for group, hl in pairs(highlights) do
   vim.api.nvim_set_hl(0, group, hl)
end
-- vim.cmd [[highlight! CmpItemKindText guifg=LightGrey]]
-- vim.cmd [[highlight! CmpItemKindFunction guifg=#C586C0]]
-- vim.cmd [[highlight! CmpItemKindClass guifg=Orange]]
-- vim.cmd [[highlight! CmpItemKindKeyword guifg=#f90c71]]
-- vim.cmd [[highlight! CmpItemKindSnippet guifg=#565c64]]
-- vim.cmd [[highlight! CmpItemKindConstructor guifg=#ae43f0]]
-- vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
-- vim.cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#f90c71]]
-- vim.cmd [[highlight! CmpItemKindFolder guifg=#2986cc]]
-- vim.cmd [[highlight! CmpItemKindReference guifg=#922b21]]
-- vim.cmd [[highlight! CmpItemKindMethod guifg=#C586C0]]
-- vim.cmd [[highlight! CmpItemMenu guibg=#C586C0 guifg=#C586C0]]
-- --background
-- --vim.cmd [[highlight! Pmenu guibg=#10171f]]
-- --vim.cmd [[highlight! PmenuSel guibg=NONE guifg=NONE gui=underline guisp=#569CD6]]
-- --menu items
-- vim.cmd [[highlight! CmpItemAbbr guibg=NONE guifg=#565c64]]
-- vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
-- vim.cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
