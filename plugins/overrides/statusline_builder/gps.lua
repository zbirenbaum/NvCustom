-- Lua

-- Customized config


local M = {}

M.setup = function ()
	local present, gps = pcall(require, "nvim-gps")
	if not present then
	 return nil
	else
		gps.setup({
			icons = {
				["class-name"] = ' ',      -- Classes and class-like objects
				["function-name"] = ' ',   -- Functions
				["method-name"] = ' ',     -- Methods (functions inside class-like objects)
				["container-name"] = ' ',  -- Containers (example: lua tables)
				["tag-name"] = '炙'         -- Tags (example: html tags)
			},

			languages = {
				-- Some languages have custom icons
				["json"] = {
					icons = {
						["array-name"] = ' ',
						["object-name"] = ' ',
						["null-name"] = '[] ',
						["boolean-name"] = 'ﰰﰴ ',
						["number-name"] = '# ',
						["string-name"] = ' '
					}
				},
				["toml"] = {
					icons = {
						["table-name"] = ' ',
						["array-name"] = ' ',
						["boolean-name"] = 'ﰰﰴ ',
						["date-name"] = ' ',
						["date-time-name"] = ' ',
						["float-name"] = ' ',
						["inline-table-name"] = ' ',
						["integer-name"] = '# ',
						["string-name"] = ' ',
						["time-name"] = ' '
					}
				},
				["verilog"] = {
					icons = {
						["module-name"] = ' '
					}
				},
				["yaml"] = {
					icons = {
						["mapping-name"] = ' ',
						["sequence-name"] = ' ',
						["null-name"] = '[] ',
						["boolean-name"] = 'ﰰﰴ ',
						["integer-name"] = '# ',
						["float-name"] = ' ',
						["string-name"] = ' '
					}
				},
			},
			separator = ' > ',
			depth = 0,
			depth_limit_indicator = ".."
		})
		return gps
	end
end

return M.setup()
