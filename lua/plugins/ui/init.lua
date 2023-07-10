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

ui.dressing = {
  spec = {
    'stevearc/dressing.nvim',
    config = {
      select = {
        backend = { 'telescope', 'nui', 'builtin' },
      },
    },
    event = 'VeryLazy',
  },
}

ui.headlines = {
  spec = {
    'lukas-reineke/headlines.nvim',
    config = {
      markdown = {
        fat_headline_lower_string = '▀',
      },
    },
    ft = { 'markdown', 'md', 'rmd' },
  },
}

ui.incline = {
  spec = {
    'b0o/incline.nvim',
    event = 'BufReadPre',
    config = function()
      local function get_diagnostic_label(props)
        local icons = { error = '', warn = '', info = '', hint = '' }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(
            props.buf,
            { severity = vim.diagnostic.severity[string.upper(severity)] }
          )
          if n > 0 then
            table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then table.insert(label, { '| ' }) end
        return label
      end

      local function get_git_diff(props)
        local icons = { removed = '', changed = '', added = '' }
        local labels = {}
        local signs = vim.api.nvim_buf_get_var(props.buf, 'gitsigns_status_dict')
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, {
              icon .. ' ' .. signs[name] .. ' ',
              group = 'Diff' .. name,
            })
          end
        end
        if #labels > 0 then table.insert(labels, { '| ' }) end
        return labels
      end

      local colors = require('tokyonight.colors').setup()
      require('incline').setup {
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.black, guifg = colors.purple },
            InclineNormalNC = { guifg = colors.purple, guibg = colors.black },
          },
        },
        window = {
          margin = { horizontal = 2, vertical = 0 },
          options = { winblend = 5 },
          padding = 0,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local icon, color = require('nvim-web-devicons').get_icon_color(filename)
          local modified = vim.api.nvim_buf_get_option(props.buf, 'modified') and { '~ ' } or { '' }
          return {
            props.focused and { '▍', group = 'VertSplit' } or { ' ' },
            { get_diagnostic_label(props) },
            { get_git_diff(props) },
            modified,
            { icon, guifg = color },
            { ' ' },
            filename,
          }
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
        mini = { win_options = { winhighlight = {}, winblend = 0 } },
        popup = { position = { row = '23', col = '50%' } },
        popupmenu = { position = { row = '23', col = '50%' } },
        cmdline_popup = {
          border = { style = 'none', padding = { 1, 1 } },
          position = { row = '23', col = '50%' },
          win_options = { winhighlight = { Normal = 'NormalFloat' } },
        },
      },
    }
  end,
}

ui.styler = {
  spec = {
    'folke/styler.nvim',
    event = 'VeryLazy',
    config = function()
      require('styler').setup {
        themes = { greeter = { colorscheme = 'tokyonight', background = 'dark' } },
      }
    end,
  },
}

ui.ansi = {
  'm00qek/baleia.nvim',
  event = 'BufReadPost',
  config = function()
    vim.cmd [[
      let s:baleia = luaeval("require('baleia').setup { }")
      command! BaleiaColorize call s:baleia.once(bufnr('%'))
    ]]
  end,
}

ui.treesitter = {
  spec = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = { 'p00f/nvim-ts-rainbow', 'nvim-treesitter/playground' },
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
    }
  end,
}

ui.win_sep = {
  spec = {
    'nvim-zh/colorful-winsep.nvim',
    config = { no_exec_files = { 'lazy', 'TelescopePrompt', 'mason', 'CompetiTest' } },
    event = 'BufWinEnter',
  },
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
  ui.ansi,
  ui.colorscheme.spec,
  ui.dressing.spec,
  ui.headlines.spec,
  ui.incline.spec,
  ui.noice.spec,
  ui.statusline.spec,
  ui.styler.spec,
  ui.treesitter.spec,
  ui.win_sep.spec,
  ui.zen_mode.spec,
}

return ui
