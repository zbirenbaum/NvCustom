
local confchoice = {
  nvim_cmp = {
    signature = "custom.plugins.cmp_configs.signature_cmp",
    autopairs = "custom.plugins.cmp_configs.autopairs_cmp",
    lsp_config = "custom.plugins.cmp_configs.lsp_config_cmp",
  },
  coq_nvim = {
    signature = "custom.plugins.coq_configs.signature_coq",
    autopairs = "custom.plugins.coq_configs.autopairs_coq",
    lsp_config = "custom.plugins.coq_configs.lsp_config_coq",
  },
}

require("" .. confchoice.coq_nvim.autopairs .."")

