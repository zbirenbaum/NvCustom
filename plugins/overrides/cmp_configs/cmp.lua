local present, cmp = pcall(require, "cmp")
local colors = require("colors").get()
local lspkind = require("custom.plugins.overrides.cmp_configs.lspkind")
local custom_comp = require("custom.plugins.overrides.cmp_configs.custom_type_comparator")


if not present then
  return
end
vim.opt.completeopt = "menuone,noselect"
--VSCODE style highlights
--vim.cmd[[ syntax on ]]



--
-- vim.cmd [[highlight! link CmpItemKindClass colors.green]]
-- vim.cmd [[highlight! link CmpItemKindInterface colors.green]]

------------------
 vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
       prefix = "",
       spacing = 8,
    },
    signs = true,
    underline = true,
    update_in_insert = true, -- update diagnostics insert mode
 })



--Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).

vim.cmd [[highlight! CmpItemKindText guifg=LightGrey]]
vim.cmd [[highlight! CmpItemKindFunction guifg=#C586C0]]
vim.cmd [[highlight! CmpItemKindClass guifg=Orange]]
vim.cmd [[highlight! CmpItemKindKeyword guifg=#f90c71]]
vim.cmd [[highlight! CmpItemKindSnippet guifg=#565c64]]
vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemKindConstructor guifg=#ae43f0]]
vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#f90c71]]
vim.cmd [[highlight! CmpItemKindFolder guifg=#2986cc]]
vim.cmd [[highlight! CmpItemKindMethod guifg=#C586C0]]

-- vim.cmd [[highlight! CmpItemKindText guifg=vibrant_green]]
-- vim.cmd [[highlight! CmpItemKindFunction guifg=dark_purple]]
-- vim.cmd [[highlight! CmpItemKindField guifg=teal]]
-- vim.cmd [[highlight! CmpItemKindValue guifg=orange]]
-- vim.cmd [[highlight! CmpItemKindKeyword guifg=pink]]
-- vim.cmd [[highlight! CmpItemKindFile guifg=orange]]

-- vim.cmd[[ highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080 ]]
-- #c882e7
-- 
-- vim.cmd[[ highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE ]]
-- vim.cmd[[ highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0 ]]
-- vim.cmd[[ highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0 ]]
-- vim.cmd[[ highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4 ]]
-- vim.cmd[[ highlight! link CmpItemMenu CmpItemKind ]]

-- nvim-cmp setup
-- #c882e7
-- vim.cmd[[ highlight CmpItemKind guifg=#ae43f0 ]]
--vim.cmd[[ highlight CmpItemMenu guifg=#ae43f0 ]]
--vim.cmd[[ highlight CmpItemMenu guifg=#f90c71 ]]
--vim.cmd[[ highlight CmpItemAbbr guifg=#565c64 ]]



cmp.setup {
  snippet = {
     expand = function(args)
       require("luasnip").lsp_expand(args.body)
     end,
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  },
--     format = function(entry, vim_item)
--       -- load lspkind icons
--       vim_item.kind = string.format(
--       "%s",
--       require("custom.plugins.cmp_configs.lspkind_icons").icons[vim_item.kind]
--       )
--       vim_item.menu = ({
--       --   -- nvim_lsp = "「LSP」 ",
--       --   -- nvim_lua = "「Lua」 ",
--       --   -- buffer = "「BUF」 ",
--         nvim_lsp = "",
--         nvim_lua = "",
--         buffer = "",
--       })[entry.source.name]
--       return vim_item
--     end,
  mapping = {
		["<PageUp>"] = function(fallback)
			for i = 1, 10 do
				cmp.mapping.select_prev_item()(nil)
			end
		end,
		["<PageDown>"] = function(fallback)
			for i = 1, 10 do
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
    { name = "nvim_lsp"},
--    { name = "luasnip" },
--    { name = "buffer" },
--    { name = "nvim_lua" },
    { name = "path"},
		--, max_item_count = 10},
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
vim.cmd [[ set pumheight=8 ]]



