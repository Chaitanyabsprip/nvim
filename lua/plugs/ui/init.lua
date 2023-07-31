local ui = {}

ui.colorscheme = require 'plugs.ui.themes'
ui.tabline = require 'plugs.ui.tabline'

ui.dressing = {
  spec = {
    'stevearc/dressing.nvim',
    opts = { select = { backend = { 'telescope', 'nui', 'builtin' } } },
    event = 'VeryLazy',
  },
}

ui.headlines = {
  spec = {
    'lukas-reineke/headlines.nvim',
    config = function()
      vim.cmd [[highlight Headline1 guibg=#1E2718]]
      vim.cmd [[highlight Headline2 guibg=#21262D]]
      vim.cmd [[highlight CodeBlock guibg=#1C1C1C]]
      vim.cmd [[highlight Dash guibg=#1C1C1C gui=bold]]
      require('headlines').setup {
        markdown = {
          -- fat_headline_lower_string = "🬂",
          fat_headline_lower_string = '▀',
          dash_string = '─',
          fat_headlines = true,
          fat_headline_upper_string = '▃',
        },
      }
    end,
    ft = { 'markdown', 'md', 'rmd', 'rst' },
  },
}

ui.noice = {
  spec = {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      { 'rcarriga/nvim-notify', opts = { render = 'compact', top_down = false } },
    },
    event = 'VeryLazy',
    opts = {
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
          ['cmp.entry.get_documentation'] = false,
        },
        message = { view = 'mini' },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      routes = {
        { filter = { event = 'msg_show', find = '%d+L, %d+B' }, view = 'mini' },
        { filter = { event = 'msg_show', find = 'after #%d+' }, view = 'mini' },
        { filter = { event = 'msg_show', find = 'before #%d+' }, view = 'mini' },
        { filter = { event = 'msg_showmode' }, view = 'mini' },
      },
      views = {
        notify = { win_options = { winblend = 0 } },
        mini = {
          align = 'message-center',
          position = { col = '50%' },
          win_options = { winhighlight = {}, winblend = 0 },
        },
        popup = { position = { row = '23', col = '50%' } },
        popupmenu = { position = { row = '23', col = '50%' } },
        cmdline_popup = {
          border = { style = 'none', padding = { 1, 1 } },
          position = { row = '23', col = '50%' },
          win_options = { winhighlight = { Normal = 'NormalFloat' } },
        },
      },
    },
  },
}

ui.styler = {
  spec = {
    'folke/styler.nvim',
    ft = 'markdown',
    opts = {
      themes = {
        markdown = { colorscheme = 'catppuccin', background = 'dark' },
      },
    },
  },
}

ui.ansi = {
  'm00qek/baleia.nvim',
  event = 'BufReadPost',
  config = function()
    local baleia = require('baleia').setup {}
    vim.api.nvim_create_user_command(
      'BaleiaColorize',
      function() baleia.once(vim.api.nvim_get_current_buf()) end,
      {}
    )
  end,
}

ui.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPre',
  config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
  opts = {
    ensure_installed = {
      'bash',
      'dart',
      'go',
      'graphql',
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
    indent = { enable = true, disable = { 'dart' } },
    rainbow = { enable = true, max_file_lines = 3000 },
    playground = {
      enable = true,
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { 'BufWrite', 'CursorHold' },
    },
  },
}

ui.win_sep = {
  spec = {
    'nvim-zh/colorful-winsep.nvim',
    opts = { no_exec_files = { 'lazy', 'TelescopePrompt', 'mason', 'CompetiTest' } },
    event = 'WinNew',
  },
}

ui.zen_mode = {
  spec = {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = { options = { number = true, relativenumber = true } },
  },
}

function ui.setup() ui.colorscheme.setup() end

ui.spec = {
  ui.ansi,
  ui.dressing.spec,
  ui.headlines.spec,
  ui.noice.spec,
  ui.styler.spec,
  ui.treesitter,
  ui.win_sep.spec,
  ui.zen_mode.spec,
  { 'nvim-treesitter/playground', cmd = { 'TsPlaygroundToggle' } },
}

return ui
