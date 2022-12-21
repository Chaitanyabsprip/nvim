local ui = {}

ui.colorscheme = require 'plugins.ui.themes'
ui.statusline = require 'plugins.ui.statusline'
ui.tabline = require 'plugins.ui.tabline'

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

ui.incline = {
  plug = {
    'b0o/incline.nvim',
    event = 'BufWinEnter',
    config = function()
      require('incline').setup {
        window = { margin = { horizontal = 2, vertical = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename)
          return {
            { icon, guifg = color },
            { ' ' },
            { filename },
          }
        end,
      }
    end,
  },
}

ui.noice = {
  plug = {
    'folke/noice.nvim',
    init = function() require('plugins.ui').noice.setup() end,
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
  },
  setup = function()
    require('noice').setup {
      cmdline = {
        -- opts = { border = 'none' },
        format = {
          substitute = {
            pattern = '^:%%?s/',
            icon = ' ',
            ft = 'regex',
            opts = { border = { text = { top = ' sub (old/new/) ' } } },
          },
        },
      },
      messages = { view_search = 'mini' },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        message = { view = 'mini' },
        documentation = { opts = { render = 'plain' } },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        cmdline_popup = {
          border = { style = 'none', padding = { 1, 1 } },
          win_options = { winhighlight = { Normal = 'NormalFloat' } },
        },
      },
    }
  end,
}

ui.startup = {
  setup = function()
    local notes_path = '/Users/chaitanyasharma/Projects/Notes/Transient/'

    local get_note_name = function()
      local date = os.date '%Y-%m-%d'
      return date .. '.md'
    end

    local new_note = function() return 'e ' .. notes_path .. get_note_name() end

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
      options = { cursor_column = 0.6, paddings = { 3, 4 } },
      parts = { 'header', 'body' },
    }
  end,
  plug = {
    'startup-nvim/startup.nvim',
    init = function() require('plugins.ui').startup.setup() end,
  },
}

ui.treesitter = {
  setup = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'dart',
        'go',
        'graphql',
        'help',
        'java',
        'javascript',
        'json',
        'kotlin',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'ruby',
        'typescript',
        'vim',
        'yaml',
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
  plug = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function() require('plugins.ui').treesitter.setup() end,
  },
}

function ui.setup() ui.highlight_override() end

ui.plug = {
  ui.colorscheme.plug,
  ui.incline.plug,
  ui.noice.plug,
  ui.startup.plug,
  ui.statusline.plug,
  ui.treesitter.plug,
}

return ui