local packer = {
  transitive_opt = true,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single",
  },
  git = {
    subcommands = {
      update = "pull --progress --rebase",
    },
    clone_timeout = 6000, -- seconds
  },
  profile = {
    enable = true,
    threshold = 0.1,
  },
  auto_reload_compiled = false,
  auto_clean = true,
  compile_on_sync = true,
}

return packer
