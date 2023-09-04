---@diagnostic disable: no-unknown
local ui = {}

local config = require 'config.ui'

---@type {spec: LazyPluginSpec, set: function}
-- ui.colorscheme = require('plugins.ui.themes.' .. config.theme)

ui.ansi = {
  'm00qek/baleia.nvim',
  optional = true,
  cond = function() return vim.loop.fs_stat 'pubspec.yaml' end,
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

ui.headlines = {
  'lukas-reineke/headlines.nvim',
  ft = { 'markdown', 'md', 'rmd', 'rst' },
  opts = {
    markdown = {
      headline_highlights = {
        'Headline1',
        'Headline2',
        'Headline3',
        'Headline4',
        'Headline5',
        'Headline6',
      },
      codeblock_highlight = { 'CodeBlock' },
      fat_headline_lower_string = '▀',
      dash_string = '─',
      fat_headlines = true,
      fat_headline_upper_string = '▃',
    },
  },
}

ui.incline = {
  enabled = false,
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
        ['cmp.entry.get_documentation'] = true,
      },
      message = { view = 'mini' },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
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

local load_textobjects = false

ui.treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPre',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        -- disable rtp plugin, as we only need its queries for mini.ai
        -- In case other textobject modules are enabled, we will load them
        -- once nvim-treesitter is loaded
        require('lazy.core.loader').disable_rtp_plugin 'nvim-treesitter-textobjects'
        load_textobjects = true
      end,
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    if load_textobjects then
      -- PERF: no need to load the plugin, if we only need its queries for mini.ai
      if opts.textobjects then
        for _, mod in ipairs { 'move', 'select', 'swap', 'lsp_interop' } do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            local Loader = require 'lazy.core.loader'
            Loader.disabled_rtp_plugins['nvim-treesitter-textobjects'] = nil
            local plugin = require('lazy.core.config').plugins['nvim-treesitter-textobjects']
            require('lazy.core.loader').source_runtime(plugin.dir, 'plugin')
            break
          end
        end
      end
    end
  end,
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
    highlight = { enable = true, additional_vim_regex_highlighting = false },
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

ui.whichkey = {
  'folke/which-key.nvim',
  event = 'BufReadPre',
  opts = {
    plugins = {},
    defaults = {
      mode = { 'n', 'v' },
      ['g'] = { name = '+goto' },
      [','] = { name = '+diagnostics' },
      [';'] = { name = '+git' },
      [']'] = { name = '+next' },
      ['['] = { name = '+prev' },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}

ui.zen_mode = {
  'folke/zen-mode.nvim',
  cmd = 'ZenMode',
  opts = { options = { statuscolumn = '', number = false, relativenumber = false } },
}

return {
  ui.ansi,
  ui.dressing,
  ui.headlines,
  ui.incline,
  ui.noice,
  ui.treesitter,
  ui.whichkey,
  ui.zen_mode,
  { 'nvim-treesitter/playground', cmd = { 'TSPlaygroundToggle' } },
  -- { 'Chaitanyabsprip/serendipity.nvim', dev = true, lazy = false },
}
