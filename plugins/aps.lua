local plugin_status = require("core.utils").load_config().plugins.status
if plugin_status.coq then
  return "custom.plugins.coq_configs.autopairs_coq"
elseif plugin_status.cmp then
  --require("custom.plugins.cmp_configs.lsp_config_cmp")
  return "custom.plugins.cmp_configs.autopairs_cmp"
end
