local ui = {}

local config = require 'config.ui'

ui.colorscheme = require('plugins.ui.themes.' .. config.theme)
ui.statusline = require 'plugins.ui.statusline'

ui.animate_movement = {
  'echasnovski/mini.animate',
  event = 'BufReadPre',
  opts = function()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false
    for _, scroll in ipairs { 'Up', 'Down' } do
      local key = '<ScrollWheel' .. scroll .. '>'
      vim.keymap.set({ '', 'i' }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    local animate = require 'mini.animate'
    return {
      resize = {
        timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
      },
      scroll = {
        timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
        subscroll = animate.gen_subscroll.equal {
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        },
      },
    }
  end,
}

ui.ansi = {
  'm00qek/baleia.nvim',
  optional = true,
  config = function()
    local baleia = require('baleia').setup {}
    vim.api.nvim_create_user_command(
      'BaleiaColorize',
      function() baleia.once(vim.api.nvim_get_current_buf()) end,
      {}
    )
  end,
}

ui.dressing = {
  'stevearc/dressing.nvim',
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('lazy').load { plugins = { 'dressing.nvim' } }
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require('lazy').load { plugins = { 'dressing.nvim' } }
      return vim.ui.input(...)
    end
  end,
  opts = { select = { backend = { 'telescope', 'nui', 'builtin' } } },
}

ui.edgy = {
  'folke/edgy.nvim',
  event = 'BufReadPre',
  opts = {
    bottom = {
      {
        ft = 'toggleterm',
        size = { height = 0.4 },
        filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == '' end,
      },
      {
        ft = 'noice',
        size = { height = 0.4 },
        filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == '' end,
      },
      {
        ft = 'lazyterm',
        title = 'LazyTerm',
        size = { height = 0.4 },
        filter = function(buf) return not vim.b[buf].lazyterm_cmd end,
      },
      { ft = 'qf', title = 'QuickFix' },
      {
        ft = 'help',
        size = { height = 20 },
        -- don't open help files in edgy that we're editing
        filter = function(buf) return vim.bo[buf].buftype == 'help' end,
      },
      { title = 'Neotest Output', ft = 'neotest-output-panel', size = { height = 15 } },
    },
    left = { { title = 'Neotest Summary', ft = 'neotest-summary' } },
    keys = {
      ['<c-Right>'] = function(win) win:resize('width', 2) end,
      ['<c-Left>'] = function(win) win:resize('width', -2) end,
      ['<c-Up>'] = function(win) win:resize('height', 2) end,
      ['<c-Down>'] = function(win) win:resize('height', -2) end,
    },
  },
}

ui.headlines = {
  'lukas-reineke/headlines.nvim',
  ft = { 'markdown', 'md', 'rmd', 'rst' },
  opts = {
    markdown = {
      fat_headline_lower_string = '▀',
      dash_string = '─',
      fat_headlines = true,
      fat_headline_upper_string = '▃',
    },
  },
}

ui.incline = {
  'b0o/incline.nvim',
  dependencies = {
    { 'folke/tokyonight.nvim', opts = { style = 'night', terminal_colors = true } },
  },
  event = 'BufReadPre',
  opts = function()
    local function get_diagnostic_label(bufnr)
      local icons = { error = '', warn = '', info = '', hint = '' }
      local label = {}
      for severity, icon in pairs(icons) do
        local n =
          #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity[string.upper(severity)] })
        if n > 0 then
          table.insert(label, { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity })
        end
      end
      if #label > 0 then table.insert(label, { '| ' }) end
      return label
    end
    local function get_git_diff(bufnr)
      local icons = { removed = '', changed = '', added = '' }
      local labels = {}
      local signs = vim.api.nvim_buf_get_var(bufnr, 'gitsigns_status_dict')
      for name, icon in pairs(icons) do
        if tonumber(signs[name]) and signs[name] > 0 then
          table.insert(labels, { icon .. ' ' .. signs[name] .. ' ', group = 'Diff' .. name })
        end
      end
      if #labels > 0 then table.insert(labels, { '| ' }) end
      return labels
    end

    local colors = require('tokyonight.colors').setup()

    return {
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
        local modified = vim.api.nvim_get_option_value('modified', { buf = props.buf }) and { '~ ' }
          or { '' }
        return {
          props.focused and { '▍ ', group = 'VertSplit' } or { ' ' },
          { get_diagnostic_label(props.buf) },
          { get_git_diff(props.buf) },
          modified,
          { icon, guifg = color },
          { ' ' },
          filename,
        }
      end,
    }
  end,
}

ui.noice = {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        max_width = function() return math.floor(vim.o.columns * 0.75) end,
        render = 'compact',
        top_down = false,
      },
    },
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
      { filter = { event = 'msg_showmode' }, opts = { skip = true } },
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
}

ui.styler = {
  'folke/styler.nvim',
  -- ft = 'markdown',
  dependencies = { { 'catppuccin/nvim', name = 'catppuccin', opts = { flavor = 'mocha' } } },
  -- opts = { themes = { markdown = { colorscheme = 'catppuccin', background = 'dark' } } },
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
  'nvim-zh/colorful-winsep.nvim',
  opts = { no_exec_files = { 'lazy', 'TelescopePrompt', 'mason', 'CompetiTest' } },
  event = 'WinNew',
}

ui.zen_mode = {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  opts = { options = { number = true, relativenumber = true } },
}

return {
  ui.animate_movement,
  ui.ansi,
  ui.colorscheme.spec,
  ui.dressing,
  ui.edgy,
  ui.headlines,
  ui.incline,
  ui.noice,
  ui.styler,
  ui.statusline,
  ui.treesitter,
  ui.win_sep,
  ui.zen_mode,
  { 'nvim-treesitter/playground', cmd = { 'TsPlaygroundToggle' } },
}
