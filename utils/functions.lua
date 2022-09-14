local path = require('plenary.path')

local ftypes = {
  vue = {
    'vue',
    'typescript',
    'javascript'
  },
}

local read_json_file = function (fname)
  local fp = path:new(fname)
  return fp:exists() and vim.json.decode(fp:read())
end

local package_installed = function(query, langfilter)
  if langfilter and not ftypes[langfilter][vim.bo.filetype] then return end
  local fname = vim.fn.expand('%:p')
  local root = require('lspconfig.util').root_pattern('package.json')(fname)
  if not root then return end
  local pkg_json = read_json_file(root .. '/package.json')
  if not pkg_json then return false end
  local deps = pkg_json.dependencies and pkg_json.dependencies[query]
  local dev_deps = pkg_json.devDependencies and pkg_json.devDependencies[query]
  return deps or dev_deps
end

return {
  read_json_file = read_json_file,
  package_installed = package_installed,
}
