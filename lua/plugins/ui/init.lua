local ui = {}

ui.colorscheme = require 'plugins.ui.themes'
ui.statusline = require 'plugins.ui.statusline'
ui.tabline = require 'plugins.ui.tabline'

function ui.highlight_override()
  if vim.g.colors_name == 'rose-pine' then
    vim.cmd [[ hi! ColorColumn guibg=#1c1a30 ctermbg=235 ]]
  elseif vim.g.colors_name == 'nightfox' then
    vim.cmd [[ hi! link TelescopeNormal NvimTreeNormal ]]
  end
  vim.cmd [[ hi! CursorLineNr guifg=#605180 gui=bold ]]
  vim.cmd [[ hi! link FoldColumn Comment ]]
  vim.cmd [[ hi! link Folded Comment ]]
  -- vim.cmd [[ hi! InlayHints guifg=#555169 ctermfg=235 ]]
  -- vim.cmd [[ hi! LineNr guifg=#1f2335 ]]
  vim.cmd [[ hi! clear CursorLine ]]
end

ui.incline = {
  spec = {
    'b0o/incline.nvim',
    event = 'BufReadPre',
    config = function()
      require('incline').setup {
        window = { margin = { horizontal = 2, vertical = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename)
          return { { icon, guifg = color }, { ' ' }, { filename } }
        end,
      }
    end,
  },
}

ui.noice = {
  spec = {
    'folke/noice.nvim',
    config = function() require('plugins.ui').noice.setup() end,
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    event = 'VeryLazy',
  },
  setup = function()
    require('noice').setup {
      cmdline = {
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
        inc_rename = true,
        lsp_doc_border = true,
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

ui.treesitter = {
  spec = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = { 'p00f/nvim-ts-rainbow' },
    config = function() require('plugins.ui').treesitter.setup() end,
  },
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
      rainbow = { enable = true, max_file_lines = 3000 },
    }
  end,
}

ui.zen_mode = {
  spec = {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = function()
      require('zen-mode').setup { options = { number = true, relativenumber = true } }
    end,
  },
}

function ui.setup() ui.highlight_override() end

ui.spec = {
  ui.zen_mode.spec,
  ui.colorscheme.spec,
  ui.incline.spec,
  ui.noice.spec,
  ui.statusline.spec,
  ui.treesitter.spec,
}

return ui
