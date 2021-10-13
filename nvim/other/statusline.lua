local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local properties = {
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
  }
}

local components = {
    active = {
        {},
        {},
        {}
    },
    inactive = {{}}
}

local colors = {
  bg = '#282E31',
  black = '#12191d',
  yellow = '#EDAF76',
  cyan = '#8B9CB2',
  green = '#9CB28B',
  orange = '#eda676',
  violet = '#7D6B97',
  white = '#F1E6D7',
  fg = '#F1E6D7',
  skyblue = '#A2C1CE',
  red = '#ed7f76',
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  VISUAL = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = ' NORMAL ',
  OP = ' OP ',
  INSERT = ' INSERT ',
  VISUAL = ' VISUAL ',
  BLOCK = ' BLOCK ',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = ' COMMAND ',
  SHELL = ' SHELL ',
  TERM = ' TERM ',
  NONE = '<>'
}

-- local buffer_not_empty = function()
--   if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--     return true
--   end
--   return false
-- end

-- local checkwidth = function()
--   local squeeze_width  = vim.fn.winwidth(0) / 2
--   if squeeze_width > 40 then
--     return true
--   end
--   return false
-- end

properties.force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

properties.force_inactive.buftypes = {
  'terminal'
}

-- LEFT
components.active[1][1] = {
  provider = function()
    return vi_mode_text[vi_mode_utils.get_vim_mode()]
  end,
  hl = function()
    local val = {}
    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'black'
    val.style = 'bold'
    return val
  end,
  -- right_sep = ' ',
  -- left_sep = ' '
}
-- filename
components.active[1][2] = {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' ',
  left_sep = ' '
}

-- MIDDLE

-- diagnosticErrors
components.active[2][1] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('Error') end,
  hl = {
    fg = 'red',
    style = 'bold'
  }
}

-- diagnosticWarn
components.active[2][2] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('Warning') end,
  hl = {
    fg = 'yellow',
    style = 'bold'
  }
}
-- diagnosticHint
components.active[2][3] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('Hint') end,
  hl = {
    fg = 'cyan',
    style = 'bold'
  }
}
-- diagnosticInfo
components.active[2][4] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('Information') end,
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}

-- RIGHT

-- lineInfo
components.active[3][1] = {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
components.active[3][2] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
  }
}



-- -- linePercent
-- components.right.active[2] = {
--   provider = 'line_percentage',
--   hl = {
--     fg = 'white',
--     bg = 'bg',
--     style = 'bold'
--   },
--   right_sep = ' '
-- }
-- -- scrollBar
-- components.right.active[3] = {
--   provider = 'scroll_bar',
--   hl = {
--     fg = 'yellow',
--     bg = 'bg',
--   },
-- }

-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
}

require('feline').setup({
  colors = colors,
  default_bg = colors.bg,
  default_fg = colors.fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  properties = properties,
})
