local ui = {}
local nnoremap = require('mappings.hashish').nnoremap
ui.themes = {}

ui.startup = {
  setup = function()
    local function time()
      local clock = ' ' .. os.date '%H:%M'
      local date = ' ' .. os.date '%d-%m-%y'
      local git_branch = require('plugins.git.git_branch').get_git_branch()
          or 'Not in a git repository'
      return { date .. '  ' .. clock, ' ' .. git_branch }
    end

    local notes_path = '/Users/chaitanyasharma/Projects/Notes/Transient/'

    local get_note_name = function()
      local date = os.date '%Y-%m-%d'
      return date .. '.md'
    end

    local new_note = function()
      return 'e ' .. notes_path .. get_note_name()
    end

    local startup = require 'startup'
    local headers = require 'startup.headers'

    startup.setup {
      header = {
        type = 'text',
        oldfiles_directory = false,
        align = 'center',
        fold_section = false,
        title = 'Header',
        margin = 5,
        content = headers.hydra_header,
        highlight = 'Statement',
        default_color = '',
        oldfiles_amount = 0,
      },
      body = {
        type = 'mapping',
        oldfiles_directory = false,
        align = 'center',
        fold_section = false,
        title = 'Basic Commands',
        margin = 5,
        content = {
          { ' Find File', 'Telescope find_files', 'f' },
          { ' Open Project', 'Telescope projects', 'h' },
          { ' Recent Files', 'Telescope oldfiles', 'm' },
          { ' Restore Session', 'RestoreSession', 'r' },
          { ' Find Sessions', 'SearchSession', 'p' },
          { ' New Note', new_note(), 'n' },
          { ' Quit ', 'quit', 'q' },
        },
        highlight = 'String',
        default_color = '',
        oldfiles_amount = 0,
      },
      footer = {
        type = 'text',
        oldfiles_directory = false,
        align = 'center',
        fold_section = false,
        title = 'Footer',
        margin = 5,
        content = time(),
        highlight = 'Number',
        default_color = '',
        oldfiles_amount = 0,
      },
      options = {
        cursor_column = 0.6,
        paddings = { 3, 4, 2 },
      },
      parts = { 'header', 'body', 'footer' },
    }
  end,
  plug = {
    'startup-nvim/startup.nvim',
    requires = {
      require('plugins.explorer').telescope.plug,
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('plugins.ui').startup.setup()
    end,
  },
}

ui.treesitter = {
  setup = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "dart",
        "go",
        "graphql",
        "java",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "python",
        "ruby",
        "typescript",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
  plug = {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufReadPre',
    config = function()
      require('plugins.ui').treesitter.setup()
    end,
  },
}

ui.lualine = {
  plug = {
    'hoob3rt/lualine.nvim',
    after = 'catppuccin',
    config = function()
      require('plugins.ui').statusline.setup()
    end,
  },
  setup = function()
    local get_lsp_client = function(msg)
      msg = msg or 'No Active Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        local client_name = client.name
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client_name ~= 'null-ls' then
          return '  ' .. client.name
        end
      end
      return msg
    end

    local function trailing_whitespace()
      local trail = vim.fn.search('\\s$', 'nw')
      if trail ~= 0 then
        return ''
      else
        return ''
      end
    end

    local theme = function()
      if vim.g.colors_name == 'material' then
        return 'material-nvim'
      else
        return 'auto'
      end
    end
    require('lualine').setup {
      options = {
        component_separators = { '', '' },
        disabled_filetypes = {},
        globalstatus = true,
        section_separators = '',
        theme = theme(),
      },
      sections = {
        lualine_a = {
          {
            'mode',
            icon = '',
            fmt = function(mode_name)
              return mode_name:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = '  ' },
          },
        },
        lualine_c = {
          'filename',
          trailing_whitespace,
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = '   ', warn = '   ' },
          },
        },
        lualine_x = {
          -- {
          --   'lsp_progress',
          --   display_components = {
          --     'spinner',
          --     { 'title', 'percentage', 'message' },
          --   },
          --   spinner_symbols = {
          --     '🌑 ',
          --     '🌘 ',
          --     '🌗 ',
          --     '🌖 ',
          --     '🌕 ',
          --     '🌔 ',
          --     '🌓 ',
          --     '🌒 ',
          --   },
          -- },
          get_lsp_client,
          'filetype',
        },
        lualine_y = {},
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'nvim-tree', 'toggleterm' },
    }
  end,
}

ui.bufferline = {
  plug = {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    config = "require ('plugins.ui').bufferline.setup()",
    event = 'BufWinEnter',
  },

  setup = function()
    require('bufferline').setup {
      options = {
        always_show_bufferline = true, -- true | false,
        color_icons = true,
        diagnostics = 'nvim_lsp', -- false | "nvim_lsp",
        enforce_regular_tabs = false, -- false | true,
        indicator = { icon = '▎', style = 'icon' },
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
        modified_icon = '●',
        numbers = 'none',
        separator_style = { '', '' }, -- "slant" | "thick" | "thin" | {'any', 'any'}, [focused and unfocused]. eg: { '|', '|' }
        show_close_icon = false, -- true | false,
        show_tab_indicators = true, -- true | false,
        sort_by = 'id', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' |
        tab_size = 18,
        function(buffer_a, buffer_b)
          return buffer_a.modified > buffer_b.modified
        end,
      },
    }

    nnoremap '<S-TAB>' '<CMD>BufferLineCyclePrev<CR>' {} 'Previous buffer'
    nnoremap '<TAB>' '<CMD>BufferLineCycleNext<CR>' {} 'Next buffer'
    nnoremap '[b' '<CMD>BufferLineMovePrev<CR>' {} 'Swap buffer position with previous buffer'
    nnoremap ']b' '<CMD>BufferLineMoveNext<CR>' {} 'Swap buffer position with next buffer'

    for i = 1, 9 do
      nnoremap('<A-' .. i .. '>')('<CMD>BufferLineGoToBuffer' .. i .. '<CR>') {} (
        'Jump to buffer' .. i
      )
    end
  end,
}

ui.themes.catppuccin = {
  plug = {
    'catppuccin/nvim',
    as = 'catppuccin',
    event = 'BufEnter',
    config = function()
      require('plugins.ui').colorscheme.setup()
    end,
  },
  setup = function()
    local catpuccin = require 'catppuccin'
    catpuccin.setup {
      flavor = 'mocha',
      term_colors = true,
      integrations = {
        treesitter = true,
        lsp_trouble = false,
        gitsigns = true,
        telescope = true,
        nvimtree = { enabled = true, show_root = false },
        which_key = true,
        markdown = true,
        ts_rainbow = true,
        hop = true,
      },
    }
    vim.cmd [[ colorscheme catppuccin ]]
  end,
}

function ui.highlight_override()
  vim.cmd [[ hi! ColorColumn guibg=#1c1a30 ctermbg=235 ]]
  if vim.g.colors_name == 'rose-pine' then
    vim.cmd [[ hi! ColorColumn guibg=#1c1a30 ctermbg=235 ]]
  elseif vim.g.colors_name == 'nightfox' then
    vim.cmd [[ hi! link TelescopeNormal NvimTreeNormal ]]
  end
  vim.cmd [[ hi! CursorLineNr guifg=#605180 gui=bold ]]
  vim.cmd [[ hi! link FoldColumn Comment ]]
  vim.cmd [[ hi! link Folded Comment ]]
  -- vim.cmd [[ hi! InlayHints guifg=#555169 ctermfg=235 ]]
  vim.cmd [[ hi! LineNr guifg=#1f2335 ]]
  vim.cmd [[ hi! clear CursorLine ]]
end

function ui.setup()
  ui.highlight_override()
  -- M.line_number_interval()
end

ui.colorscheme = ui.themes.catppuccin
ui.statusline = ui.lualine
ui.plug = {
  ui.colorscheme.plug,
  ui.treesitter.plug,
  ui.startup.plug,
  ui.statusline.plug,
  ui.bufferline.plug,
}

return ui
