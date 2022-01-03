local colors = require("colors").get()
local lsp = require "feline.providers.lsp"
local C = {}
local config = require("core.utils").load_config().plugins.options.statusline
local shortline = config.shortline == false and true

local statusline_style = {
  left = "",
  right = "",
  main_icon = "  ",
  vi_mode_icon = " ⚡",
  position_icon = " ",
}

local sep_spaces= {
  left = " ",
  right = "",
}
local empty="NONE"

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}


local chad_mode_hl = function()
  return {
    fg=mode_colors[vim.fn.mode()][2],
    --bg=colors.lightbg,
    bg = empty,
  }
end

C.main_icon = {
  provider = statusline_style.main_icon,
  hl = {
    fg=empty,
    bg=colors.nord_blue,
  },
  left_sep={
    str = statusline_style.right,
    hl = {
      fg=colors.nord_blue,
      bg=colors.lightbg,
    },
  },
}

C.file={
  provider = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if filename == nil or filename == "" or filename == " " then
      return ""
    end
    if icon == nil then
      return " " .. filename .. " "
      --icon = ""
      --return icon
    end
    return " " .. icon .. " " .. filename .. " "
  end,
  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 70
  end,
  hl = {
    fg = colors.white,
    bg = colors.lightbg,
  },
  left_sep = {
    str = sep_spaces.left,
    hl = {
      fg=colors.lightbg,
      bg=empty,
    },
  },
  right_sep = {
    str = " ",
    hl = {
      fg=colors.lightbg,
      bg=empty,
    }
  },
}


--   right_sep = { str = statusline_style.right, hl = { fg = colors.lightbg, bg = colors.lightbg2 } },
-- }

C.dir = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return "  " .. dir_name .. " "
  end,

  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 80
  end,

  hl = {
    fg=colors.cyan,
    bg=colors.lightbg,
  },
  left_sep = {
    str = " " .. statusline_style.left,
    hl = {
      fg=colors.lightbg,
      bg=empty,
    }
  },
  right_sep = {
    str = sep_spaces.right,
    hl = {
      fg=colors.lightbg,
      bg=empty,
    },
  },
}

C.git = {
  added={
    provider = "git_diff_added",
    hl = {
      fg = colors.green,
      bg = empty,
    },
    --icon = "  ",
    icon = "  ",
  },
  changed={
    provider = "git_diff_changed",
    hl = {
      fg = colors.orange,
      bg = empty,
    },
    icon = "  ",
  },
  removed={
    provider = "git_diff_removed",
    hl = {
      fg = colors.red,
      bg = empty,
    },
    --icon = "  ",
    icon = "  ",
  },

  branch = {
    provider = "git_branch",
    enabled = shortline or function(winid)
      local path = vim.fn.expand('%:p')
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo=true
      end
      return gitrepo and vim.api.nvim_win_get_width(winid) > 70
    end,
    hl = {
      fg = colors.nord_blue,
      bg= empty,
    },
    icon = {
      str = "  ",
      hl = {
        fg = colors.green,
        bg = empty,
      },
    },
  },
  branch_bg = {
    provider = "git_branch",
    enabled = shortline or function(winid)
      local path = vim.fn.expand('%:p')
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo=true
      end
      return gitrepo and vim.api.nvim_win_get_width(winid) > 70
    end,
    hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
    },
    icon = {
      str = "  ",
      hl = {
        fg = colors.green,
        bg = colors.lightbg,
      },
    },
    left_sep = {
      str = " " .. statusline_style.left,
      hl = {
        fg=colors.lightbg,
        bg=empty,
      }
    },
  },
  git_sep = {
    provider = " ",
    enabled = function(winid)
      local path = vim.fn.expand('%:p')
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo=true
      end
      return gitrepo and vim.api.nvim_win_get_width(winid) > 70
    end,
    hl = {
      bg=colors.lightbg,
      fg=empty,
    },
    right_sep = {
      str = statusline_style.right,
      hl = {
        fg=colors.lightbg,
        bg=empty,
      }
    }
  }
}

C.diagnostics={
  errors = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist "ERROR"
    end,

    hl = { bg=empty, fg = colors.red },
    icon = "  ",
  },
  warnings = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist "WARN"
    end,
    hl = { bg=empty, fg = colors.yellow },
    icon = "  ",
  },
  hints = {
    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist "HINT"
    end,
    hl = { bg=empty, fg = colors.grey_fg2 },
    icon = "  ",
  },
  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist "INFO"
    end,
    hl = { bg=empty, fg = colors.green },
    icon = "  ",
  },

  spacer = {
    provider = "  ",
    hl = { bg=empty, fg = colors.empty },
  }
}

C.progress = {
   provider = function()
      local Lsp = vim.lsp.util.get_progress_messages()[1]

      if Lsp then
         local msg = Lsp.message or ""
         local percentage = Lsp.percentage or 0
         local title = Lsp.title or ""
         local spinners = {
            "",
            "",
            "",
         }

         local success_icon = {
            "",
            "",
            "",
         }

         local ms = vim.loop.hrtime() / 1000000
         local frame = math.floor(ms / 120) % #spinners

         if percentage >= 70 then
            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
         end

         return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end

      return ""
   end,
   enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 80
   end,
   hl = { fg = colors.green, bg = empty },
}

C.lsp = {
  provider="lsp_client_names",
  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 70
  end,
  hl = { fg = colors.nord_blue, bg = empty },
}
C.mode = {
  left_sep = {
    provider = statusline_style.left,
    hl = function()
      return {
        fg = colors.lightbg,
        bg = empty,
      }
    end,
  },
  right_sep = {
    provider = statusline_style.right,
    hl = function()
      return {
        fg = colors.lightbg,
        bg = empty,
      }
    end,
  },
  mode_icon = {
    provider = statusline_style.vi_mode_icon,
    hl = function()
      return {
        bg = empty, --colors.lightbg,
        fg = mode_colors[vim.fn.mode()][2],
      }
    end,
  },
  mode_string = {
    provider = function()
      return " " .. mode_colors[vim.fn.mode()][1] .. ""
    end,
    hl = chad_mode_hl,
  }
}
C.location = {
  left_sep = {
    provider = " " .. statusline_style.left,
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,
    hl = {
      fg = colors.green,
      bg = empty,
    },
  },
  loc_icon = {
    provider = "  " .. statusline_style.position_icon,
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,
    hl = {
      fg = colors.green,
      bg=empty,
      --fg = colors.black,
      --bg = colors.green,
    },
  },
  loc_string = {
    provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
        return "Top "
      elseif current_line == vim.fn.line "$" then
        return "Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return "" .. result .. "%% "
    end,

    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,

    hl = {
      fg = colors.green,
      bg = empty,
      --      fg = colors.green,
      --      bg = colors.one_bg,
    },
  },
}
C.gps = {
  provider = function ()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    if filename == nil or filename == "" or filename == " " then
      return ""
    else
      local gps = require "custom.plugins.statusline_builder.gps"
      if gps and gps.is_available() then
        return gps.get_location()
      else
	return ""
      end
    end
  end,
  hl = {
    fg = "#EA2DEF",
    bg = empty,
    --      fg = colors.green,
    --      bg = colors.one_bg,
  },
}

return C
