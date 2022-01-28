local lsp_setup = require("custom.plugins.lsp_plugins.nvim_lsp_setup")

local default_lsp_config = function(attach, capabilities)
   local default_config = {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
         debounce_text_changes = 150,
      }
   }
   return default_config
end

local setup_func = function(completion_engine, config_table)
   if completion_engine == "coq" then
      local coq = require("coq")
      return coq.lsp_ensure_capabilities(config_table)
   else
      return config_table
   end
end

local M = {}

M.setup_lsp = function(completion_engine)
   lsp_setup.config_handlers()
   lsp_setup.config_diagnostics()
   local attach = lsp_setup.attach()
   local capabilities = lsp_setup.setup_capabilities()
   if not completion_engine then completion_engine = {} end
   local lspconfig = require "lspconfig"
   local default_servers = {"clangd"}
   local custom_servers = {"sumneko_lua", "pylance"}
   local default_config = default_lsp_config(attach, capabilities)

   for _, lsp in ipairs(custom_servers) do
      local config_table = require("custom.plugins.lsp_plugins.lsp_configs." .. lsp).config_table(attach, capabilities) or default_lsp_config
      lspconfig[lsp].setup(setup_func(completion_engine, config_table))
   end
   for _, lsp in ipairs(default_servers) do
      lspconfig[lsp].setup(setup_func(completion_engine, default_config))
   end
end

return M
