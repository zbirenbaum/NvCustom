local path = require('plenary.path')

local read_json_file = function (fname)
  local fp = path:new(fname)
  return fp:exists() and vim.json.decode(fp:read())
end

local package_installed = function(query)
  local pkg_json = read_json_file('package.json')
  if not pkg_json then return false end
  local deps = pkg_json.dependencies and pkg_json.dependencies[query]
  local dev_deps = pkg_json.devDependencies and pkg_json.devDependencies[query]
  return deps or dev_deps
end

return {
  read_json_file = read_json_file,
  package_installed = package_installed,
}
