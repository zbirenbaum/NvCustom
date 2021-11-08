local plugin_status = require("core.utils").load_config().plugins.status
if plugin_status.coq then
  require "custom.plugins.coq_configs.autopairs_coq"
elseif plugin_status.cmp then
  require "custom.plugins.cmp_configs.autopairs_cmp"
end
