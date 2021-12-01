local colors = require("colors").get()
local lsp = require "feline.providers.lsp"
--local lsp = require "feline.providers.lsp"
local C = {}
--local config = require("core.utils").load_config().plugins.options.statusline
-- statusline style
-- if show short statusline on small screens
--local shortline = config.shortline == false and true
local shortline = true

local statusline_style = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
}

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
    bg=colors.statusline_bg,
  }
end

C.main_icon = {
  provider = statusline_style.main_icon,
  hl = {
    fg=colors.statusline_bg,
    bg=colors.nord_blue,
  },
  right_sep = {
    str = statusline_style.right,
    hl = {
      fg=colors.nord_blue,
      bg=colors.lightbg,
    }
  },
}

C.file={
  provider = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
      icon = " "
      return icon
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

  right_sep = { str = statusline_style.right, hl = { fg = colors.lightbg, bg = colors.lightbg2 } },
}

C.dir = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return "  " .. dir_name .. " "
  end,

  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 80
  end,

  hl = {
    fg = colors.grey_fg2,
    bg = colors.lightbg2,
  },
  right_sep = {
    str = statusline_style.right,
    hi = {
      fg = colors.lightbg2,
      bg = colors.statusline_bg,
    },
  },
}

C.git = {
  [1]={
    provider = "git_diff_added",
    hl = {
      fg = colors.green,
      bg = colors.statusline_bg,
    },
    icon = " ",
  },
  [2]={
    provider = "git_diff_changed",
    hl = {
      fg = colors.orange,
      bg = colors.statusline_bg,
    },
    icon = "   ",
  },
  [3]={
    provider = "git_diff_removed",
    hl = {
      fg = colors.red,
      bg = colors.statusline_bg,
    },
    icon = "  ",
  },
  branch = {
    provider = "git_branch",
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 70
    end,
    hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg,
    },
    icon = "  ",
  }
}
C.diagnostics={
  errors = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist "Error"
    end,

    hl = { fg = colors.red },
    icon = "  ",
  },
  warnings = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist "Warning"
    end,
    hl = { fg = colors.yellow },
    icon = "  ",
  },
  hints = {
    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist "Hint"
    end,
    hl = { fg = colors.grey_fg2 },
    icon = "  ",
  },
  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist "Information"
    end,
    hl = { fg = colors.green },
    icon = "  ",
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
      else
        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
      end
    end
    return ""
  end,
  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 80
  end,
  hl = { fg = colors.green },
}
C.lsp = {
  provider = function()
    if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
    else
      return ""
    end
  end,
  enabled = shortline or function(winid)
    return vim.api.nvim_win_get_width(winid) > 70
  end,
  hl = { fg = colors.grey_fg2, bg = colors.statusline_bg },
}
C.mode = {
  left_sep = {
    provider = statusline_style.left,
    hl = function()
      return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = colors.statusline_bg,
      }
    end,
  },
  mode_icon = {
    provider = statusline_style.vi_mode_icon,
    hl = function()
      return {
        fg = colors.statusline_bg,
        bg = mode_colors[vim.fn.mode()][2],
      }
    end,
  },
  mode_string = {
    provider = function()
      return " " .. mode_colors[vim.fn.mode()][1] .. " "
    end,
    hl = chad_mode_hl,
  }
}
C.location = {
  left_sep = {
    provider = statusline_style.left,
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,
    hl = {
      fg = colors.green,
      bg = colors.statusline_bg,
    },
  },
  loc_icon = {
    provider = statusline_style.position_icon,
    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,
    hl = {
      fg = colors.black,
      bg = colors.green,
    },
  },
  loc_string = {
    provider = function()
      local current_line = vim.fn.line "."
      local total_line = vim.fn.line "$"

      if current_line == 1 then
        return " Top "
      elseif current_line == vim.fn.line "$" then
        return " Bot "
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return " " .. result .. "%% "
    end,

    enabled = shortline or function(winid)
      return vim.api.nvim_win_get_width(winid) > 90
    end,

    hl = {
      fg = colors.green,
      bg = colors.one_bg,
    },
  },
}

return C
