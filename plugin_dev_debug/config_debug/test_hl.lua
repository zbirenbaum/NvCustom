local fn = vim.fn

local function get_color(group, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

print(fn.synIDattr(fn.synIDtrans(fn.hlID("Normal")), "fg"))
