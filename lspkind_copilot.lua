
local lspkind = {}
lspkind.symbol_map = {
  Boolean = "[] Boolean",
  Character = "[] Character",
  Class = "[] Class",
  Color = "[] Color",
  Constant = "[] Constant",
  Constructor = "[] Constructor",
  Enum = "[] Enum",
  EnumMember = "[] EnumMember",
  Event = "[ﳅ] Event",
  Field = "[] Field",
  File = "[] File",
  Folder = "[ﱮ] Folder",
  Function = "[ﬦ] Function",
  Interface = "[] Interface",
  Keyword = "[] Keyword",
  Method = "[] Method",
  Module = "[] Module",
  Number = "[] Number",
  Operator = "[Ψ] Operator",
  Parameter = "[] Parameter",
  Property = "[ﭬ] Property",
  Reference = "[] Reference",
  Snippet = "[] Snippet",
  String = "[] String",
  Struct = "[ﯟ] Struct",
  Text = "[] Text",
  TypeParameter = "[] TypeParameter",
  Unit = "[] Unit",
  Value = "[] Value",
  Variable = "[ﳛ] Variable",
  Copilot = "[ﯙ] Copilot",
}

local kind_order = {
  'Text', 'Method', 'Function', 'Constructor', 'Field', 'Variable', 'Class', 'Interface', 'Module',
  'Property', 'Unit', 'Value', 'Enum', 'Keyword', 'Snippet', 'Color', 'File', 'Reference', 'Folder',
  'EnumMember', 'Constant', 'Struct', 'Event', 'Operator', 'TypeParameter', 'Copilot'
}

for ind,kind in pairs(kind_order) do
  require('vim.lsp.protocol').CompletionItemKind[ind] = lspkind.symbol_map[kind]
  require('vim.lsp.protocol').CompletionItemKind[kind] = ind
end

function lspkind.cmp_format(opts)
  return function(entry, vim_item)
    if opts.before then
      vim_item = opts.before(entry, vim_item)
    end
    vim_item.kind = lspkind.symbol_map[vim_item.kind]
    if opts.menu ~= nil then
      vim_item.menu = opts.menu[entry.source.name]
    end
    if opts.maxwidth ~= nil then
        vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
    end
    return vim_item
  end
end

return lspkind
