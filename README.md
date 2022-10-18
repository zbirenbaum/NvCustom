# Config Guide
## IMPORTANT NOTE:
This does not currently work with NvChad. If I have time in the future I will update this, but at the moment I am too busy with a new job and other repositories to maintain this. I currently am using my own config which was made by pretty much just using sed to remove `custom.` from every require path and writing a short `init.lua`, along with a few other minor changes.

You can find said repo here (although there is still some organizational work to do): https://github.com/zbirenbaum/zvim

NvChad is an awesome project, and I will continue to help maintain it, but given the nature of my current work and editor needs, it does not make sense for me to prioritize making my config (which is very likely larger than NvChad itself at this point) compatible, when it has essentially been standalone for the better part of a year.



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

