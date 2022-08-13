local lspkind = require("lspkind")

lspkind.init({
  symbol_map = {
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
    Copilot = "[]"
  },
})

return lspkind
