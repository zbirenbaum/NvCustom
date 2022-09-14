local config_table = function (attach, capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities,
    attach = attach,
    init_options = {
      {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        },
        provideFormatter = true
      }
    },
    settings = {
      html = {
        format = {
          templating = true,
          wrapLineLength = 120,
          wrapAttributes = 'auto',
        },
        hover = {
          documentation = true,
          references = true,
        },
      },
    },
    single_file_support = true,
  }
end

return { config_table = config_table }
