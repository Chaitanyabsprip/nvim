local gl = require('galaxyline')
local gls = gl.section

gl.short_line_list = {'vista', 'dbui', 'term'}

local colors = {
  bg = '#212738',
  line_bg = '#7D0AB2',
  fg = '#8FBCBB',
  NameColor = '#414C63',
  fg_green = '#65a380',
  cocColor = '#6CCFF6',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#AB47BC',
  orange = '#F4B02A',
  purple = '#5d4d7a',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local get_lsp_client = function(msg)
  msg = msg or 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    local client_id = client.id
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client_name ~=
        "efm" then
      return client.name
    end
  end
  return msg
end

local function lsp_status(status)
  Shorter_stat = ''
  for match in string.gmatch(status, "[^%s]+") do
    Err_warn = string.find(match, "^[WE]%d+", 0)
    if not Err_warn then
      Shorter_stat = Shorter_stat .. ' ' .. match
    end
  end
  return Shorter_stat
end

local function get_coc_lsp()
  local status = vim.fn['coc#status']()
  if not status or status == '' then
    return ''
  end
  return lsp_status(status)
end

function Get_diagnostic_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_coc_lsp()
  end
  return ''
end

local function get_current_func()
  local has_func, func_name = pcall(vim.fn.nvim_buf_get_var, 0,
                                    'coc_current_function')
  if not has_func then
    return
  end
  return func_name
end

function Get_function_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_current_func()
  end
  return ''
end

local function trailing_whitespace()
  local trail = vim.fn.search("\\s$", "nw")
  if trail ~= 0 then
    return ' '
  else
    return nil
  end
end

CocStatus = Get_diagnostic_info
CocFunc = get_current_func
TrailingWhiteSpace = trailing_whitespace

function Has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then
    return false
  end
  return true
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
        n = '▋ ',
        i = '▋ ',
        V = '▋ ',
        [''] = '▋ ',
        v = '▋ ',
        c = '▋ ',
        ['r?'] = '▋ ',
        rm = '▋ ',
        R = '▋ ',
        Rv = '▋ ',
        s = '▋ ',
        S = '▋ ',
        ['r'] = '▋ ',
        [''] = '▋ ',
        t = '▋ ',
        ['!'] = '▋ '
      }
      local mode_color = {
        n = colors.green,
        i = colors.blue,
        v = colors.magenta,
        [''] = colors.blue,
        V = colors.blue,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        cv = colors.red,
        ce = colors.red,
        ['!'] = colors.green,
        t = colors.green,
        no = colors.magenta,
        c = colors.purple,
        ['r?'] = colors.red,
        ['r'] = colors.red,
        rm = colors.red,
        R = colors.yellow,
        Rv = colors.magenta
      }
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim_mode])
      return alias[vim_mode] .. '  '
    end,
    highlight = {colors.red, colors.bg, 'bold'}
  }
}
gls.left[3] = {
  BOOLNS = {
    provider = function()
    end,
    separator = ' ',
    condition = buffer_not_empty,
    separator_highlight = {colors.NameColor, colors.bg}
  }
}
-- 文件图标
gls.left[4] = {
  FileIcon = {
    provider = 'FileIcon',
    icon = ' ',
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.NameColor
    }
  }
}
gls.left[5] = {
  FileName = {
    provider = {'FileName'},
    separator = ' ',
    condition = buffer_not_empty,
    separator_highlight = {colors.NameColor, colors.bg},
    highlight = {colors.fg, colors.NameColor, 'bold'}
  }
}

gls.left[6] = {
  FileSize = {
    provider = {'FileSize'},
    condition = buffer_not_empty,
    highlight = {colors.cocColor, colors.bg}
  }
}

gls.left[7] = {
  GitIcon = {
    provider = function()
      return '  ﯙ '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange, colors.purple}
  }
}
gls.left[8] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {'#8FBCBB', colors.purple, 'bold'}
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[9] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.green, colors.purple}
  }
}
gls.left[10] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.orange, colors.purple}
  }
}
gls.left[11] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '  ',
    highlight = {colors.red, colors.purple}
  }
}
gls.left[12] = {
  LeftEnd = {
    provider = function()
      return ''
    end,
    separator = ' ',

    separator_highlight = {colors.bg, colors.purple},
    highlight = {colors.purple, colors.purple}
  }
}

gls.left[13] = {
  TrailingWhiteSpace = {
    provider = TrailingWhiteSpace,
    icon = '   ',
    highlight = {colors.yellow, colors.bg}
  }
}

gls.left[14] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '   ',
    highlight = {colors.red, colors.bg}
  }
}
gls.left[15] = {
  Space = {
    provider = function()
      return ''
    end
  }
}
gls.left[16] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '   ',
    highlight = {colors.yellow, colors.bg}
  }
}

gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = '   ',
    highlight = {colors.fg, colors.purple}
  }
}
gls.right[4] = {
  ScrollBar = {
    provider = 'ScrollBar',
    separator = ' ● ',
    separator_highlight = {colors.blue, colors.purple},
    highlight = {colors.yellow, colors.bg}
  }
}

gls.right[1] = {
  ShowLspClient = {
    provider = get_lsp_client,
    condition = function()
      local tbl = {['dashboard'] = true, [' '] = true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' ',
    highlight = {colors.grey, colors.bg}
  }
}

gls.short_line_left[3] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '█',
    condition = Has_file_type,
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.fg, colors.purple}
  }
}
gls.short_line_left[2] = {
  BOOLNS = {
    provider = function()
    end,
    separator = '█',
    condition = buffer_not_empty,
    separator_highlight = {colors.NameColor, colors.bg}
  }
}
gls.short_line_left[1] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
        n = '█▋ ',
        i = '█▋ ',
        V = '█▋ ',
        [''] = '█▋ ',
        v = '█▋ ',
        c = '█▋ ',
        ['r?'] = '█▋ ',
        rm = '█▋ ',
        R = '█▋',
        Rv = '█▋ ',
        s = '█▋ ',
        S = '█▋ ',
        ['r'] = '█▋ ',
        [''] = '█▋ ',
        t = '█▋ ',
        ['!'] = '▋ '
      }
      local mode_color = {
        n = colors.green,
        i = colors.blue,
        v = colors.magenta,
        [''] = colors.blue,
        V = colors.blue,
        no = colors.magenta,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        cv = colors.red,
        ce = colors.red,
        ['!'] = colors.green,
        t = colors.green,
        c = colors.purple,
        ['r?'] = colors.red,
        ['r'] = colors.red,
        rm = colors.red,
        R = colors.yellow,
        Rv = colors.magenta
      }
      local vim_mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim_mode])
      return alias[vim_mode] .. '   '
    end,
    highlight = {colors.red, colors.purple, 'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    separator = '█',
    condition = Has_file_type,
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.fg, colors.purple}
  }
}
