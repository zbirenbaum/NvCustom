# Config Guide
Below are some descriptions of the various folders and files you will find here. I haven't had time to make a full setup guide but probably will in a week or two. (as of Dec. 16) At the bottom are the last couple lines of the startuptime log. Spoiler, with no file, its ~26.9 milliseconds, and ~89.3 milliseconds opening a file like chadrc which triggers the max number of plugins. This is quite literally about 4 milliseconds slower than running a vanilla NvChad config with no custom dir in my tests. That includes no LSP. Good luck beating that performance with this many plugins and configs. I actually wanted to beat NvChad vanilla, but that will have to wait for after finals I suppose.

## custom/
### chadrc.lua
chadrc contains the configuration for NvChad functionality, as well as the flags to enable and disable the custom plugins included in init.lua. It also is responsible for sourcing the lua file which sets globals and some hotkeys that did not really fit in to a respective plugin file intuitively.
### init.lua
Contains custom plugins and calls their configs
### mappings.lua
a couple etc mappings
### set_globals.lua
sets environment variables. If you clone this repo, you will likely need to change some stuff in here.

## custom/plugins
### cmp, CoQ, and lsp guide
You will notice there are a bunch of folders with 'cmp' and 'CoQ' and the like in their name. These provide the functionality for hotswapping cmp and CoQ in the chadrc file, as cmp and CoQ require different configs for certain plugins like autopairs.
### lsp configs
The default lsp configurations for a few language servers are overwritten in the lspconfigs dir.

### all other custom plugin configs
the configuration files for all plugins overrided in chadrc and installed in init.lua are contained in this dir.

## Startup Times
### No input file
```
024.924  000.054: before starting main loop
026.893  001.969: first screen update
026.895  000.002: --- NVIM STARTED ---
```
### Opening chadrc (Loads LSP+Other Plugins)
```
065.857  000.068: before starting main loop
089.302  023.444: first screen update
089.304  000.002: --- NVIM STARTED ---
```
