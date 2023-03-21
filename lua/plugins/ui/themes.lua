local themes = {}
local config = function() return require 'plugins.ui.config' end

local t = function() return require 'plugins.ui.themes' end

themes.catppuccin = {
  spec = {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function() t().catppuccin.setup() end,
  },
  setup = function()
    require('catppuccin').setup {
      flavor = 'mocha',
      term_colors = true,
      transparent_background = true,
      custom_highlights = function(c)
        return {
          CmpItemKindConstructor = { fg = c.base, bg = c.blue },
          CmpItemKindEvent = { fg = c.base, bg = c.blue },
          CmpItemKindFile = { fg = c.base, bg = c.blue },
          CmpItemKindFolder = { fg = c.base, bg = c.blue },
          CmpItemKindFunction = { fg = c.base, bg = c.blue },
          CmpItemKindMethod = { fg = c.base, bg = c.blue },
          CmpItemKindModule = { fg = c.base, bg = c.blue },
          CmpItemKindOperator = { fg = c.base, bg = c.blue },
          CmpItemKindStruct = { fg = c.base, bg = c.blue },
          CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
          CmpItemKindEnum = { fg = c.base, bg = c.green },
          CmpItemKindField = { fg = c.base, bg = c.green },
          CmpItemKindProperty = { fg = c.base, bg = c.green },
          CmpItemKindUnit = { fg = c.base, bg = c.green },
          CmpItemKindKeyword = { fg = c.base, bg = c.red },
          CmpItemKindReference = { fg = c.base, bg = c.red },
          CmpItemKindEnumMember = { fg = c.base, bg = c.red },
          CmpItemKindColor = { fg = c.base, bg = c.red },
          CmpItemKindClass = { fg = c.base, bg = c.yellow },
          CmpItemKindInterface = { fg = c.base, bg = c.yellow },
          CmpItemKindValue = { fg = c.base, bg = c.peach },
          CmpItemKindConstant = { fg = c.base, bg = c.peach },
          CmpItemKindCopilot = { fg = c.base, bg = c.teal },
          CmpItemKindText = { fg = c.base, bg = c.teal },
          CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
          CmpItemKindVariable = { fg = c.base, bg = c.flamingo },
          LeapBackdrop = { fg = '#545c7e' },
        }
      end,
      integrations = {
        gitsigns = true,
        harpoon = true,
        leap = true,
        markdown = true,
        mini = true,
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = { enabled = true, show_root = true },
        semantic_tokens = true,
        treesitter = true,
        ts_rainbow = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
  set = function() vim.cmd.colorscheme 'catppuccin' end,
}

themes.github = {
  spec = {
    'projekt0n/github-nvim-theme',
    version = '*',
    config = function() t().github.setup() end,
    lazy = false,
  },
  setup = function()
    require('github-theme').setup {
      theme_style = 'dark_default',
      dark_float = true,
      sidebars = { 'qf', 'terminal', 'nvimtree', 'telescope', 'harpoon', 'neotest' },
      dev = true,
      overrides = function(c)
        return {
          CmpItemKindConstructor = { fg = c.base, bg = c.blue },
          CmpItemKindEvent = { fg = c.base, bg = c.blue },
          CmpItemKindFile = { fg = c.base, bg = c.blue },
          CmpItemKindFolder = { fg = c.base, bg = c.blue },
          CmpItemKindFunction = { fg = c.base, bg = c.blue },
          CmpItemKindMethod = { fg = c.base, bg = c.blue },
          CmpItemKindModule = { fg = c.base, bg = c.blue },
          CmpItemKindOperator = { fg = c.base, bg = c.blue },
          CmpItemKindStruct = { fg = c.base, bg = c.blue },
          CmpItemKindTypeParameter = { fg = c.base, bg = c.blue },
          CmpItemKindEnum = { fg = c.base, bg = c.green },
          CmpItemKindField = { fg = c.base, bg = c.green },
          CmpItemKindProperty = { fg = c.base, bg = c.green },
          CmpItemKindUnit = { fg = c.base, bg = c.green },
          CmpItemKindKeyword = { fg = c.base, bg = c.red },
          CmpItemKindReference = { fg = c.base, bg = c.red },
          CmpItemKindEnumMember = { fg = c.base, bg = c.red },
          CmpItemKindColor = { fg = c.base, bg = c.red },
          CmpItemKindClass = { fg = c.base, bg = c.yellow },
          CmpItemKindInterface = { fg = c.base, bg = c.yellow },
          CmpItemKindValue = { fg = c.base, bg = c.peach },
          CmpItemKindConstant = { fg = c.base, bg = c.peach },
          CmpItemKindCopilot = { fg = c.base, bg = c.teal },
          CmpItemKindText = { fg = c.base, bg = c.teal },
          CmpItemKindSnippet = { fg = c.base, bg = c.mauve },
          CmpItemKindVariable = { fg = c.base, bg = c.flamingo },

          LeapBackdrop = { fg = '#545c7e' },
        }
      end,
    }
  end,
  set = function() end,
}

themes.rosepine = {
  spec = {
    'rose-pine/neovim',
    -- 'denspiro/rose-pine',
    -- 'sindrets/rose-pine-neovim',
    name = 'rose-pine',
    config = function() require('plugins.ui.themes').rosepine.setup() end,
    lazy = false,
  },
  setup = function()
    vim.o.background = 'dark'
    require('rose-pine').setup {
      dark_variant = 'main',
      disable_background = true,
      highlight_groups = {
        CmpItemAbbr = { fg = 'subtle' },
        CmpItemAbbrDeprecated = { fg = 'subtle' },
        CmpItemAbbrMatch = { fg = 'iris' },
        CmpItemAbbrMatchFuzzy = { fg = 'iris' },
        CmpItemKind = { fg = 'base', bg = 'iris' },
        CmpItemKindClass = { fg = 'base', bg = 'gold' },
        CmpItemKindColor = { fg = 'base', bg = 'love' },
        CmpItemKindConstant = { fg = 'base', bg = 'rose' },
        CmpItemKindConstructor = { fg = 'base', bg = 'foam' },
        CmpItemKindCopilot = { fg = 'base', bg = 'iris' },
        CmpItemKindEnum = { fg = 'base', bg = 'pine' },
        CmpItemKindEnumMember = { fg = 'base', bg = 'love' },
        CmpItemKindEvent = { fg = 'base', bg = 'foam' },
        CmpItemKindField = { fg = 'base', bg = 'pine' },
        CmpItemKindFile = { fg = 'base', bg = 'foam' },
        CmpItemKindFolder = { fg = 'base', bg = 'foam' },
        CmpItemKindFunction = { fg = 'base', bg = 'iris' },
        CmpItemKindInterface = { fg = 'base', bg = 'gold' },
        CmpItemKindKeyword = { fg = 'base', bg = 'love' },
        CmpItemKindMethod = { fg = 'base', bg = 'iris' },
        CmpItemKindModule = { fg = 'base', bg = 'foam' },
        CmpItemKindOperator = { fg = 'base', bg = 'foam' },
        CmpItemKindProperty = { fg = 'base', bg = 'pine' },
        CmpItemKindReference = { fg = 'base', bg = 'love' },
        CmpItemKindSnippet = { fg = 'base', bg = 'iris' },
        CmpItemKindStruct = { fg = 'base', bg = 'foam' },
        CmpItemKindText = { fg = 'base', bg = 'iris' },
        CmpItemKindTypeParameter = { fg = 'base', bg = 'foam' },
        CmpItemKindUnit = { fg = 'base', bg = 'pine' },
        CmpItemKindValue = { fg = 'base', bg = 'rose' },
        CmpItemKindVariable = { fg = 'base', bg = 'foam' },
        TelescopeBorder = { fg = 'surface', bg = 'surface' },
        TelescopeNormal = { bg = 'surface', fg = 'muted' },
        TelescopePromptCounter = { fg = 'text', bg = 'base' },
        TelescopePromptBorder = { fg = 'base', bg = 'base' },
        TelescopePromptNormal = { fg = 'text', bg = 'base' },
        TelescopePromptPrefix = { fg = 'gold' },
        TelescopeMatching = { fg = 'text' },
        TelescopeSelection = { fg = 'muted', bg = 'overlay' },
        TelescopeSelectionCaret = { fg = 'rose', bg = 'overlay' },
        TelescopeTitle = { fg = 'muted', bg = 'love' },
        TelescopePreviewTitle = { fg = 'base', bg = 'iris' },
        TelescopePromptTitle = { fg = 'base', bg = 'love' },
        TelescopeResultsTitle = { fg = 'base', bg = 'foam' },
        NotifyBackground = { bg = 'base' },
        MatchParen = { fg = 'none', bg = 'highlight_med' },
        LeapBackdrop = { fg = '#545c7e' },
      },
    }
    vim.cmd.colorscheme 'rose-pine'
  end,
}

themes.tokyonight = {
  spec = {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function() t().tokyonight.setup() end,
    event = 'VeryLazy',
  },
  setup = function()
    local tokyonight = require 'tokyonight'
    tokyonight.setup {
      style = 'night',
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'italic',
        variables = 'italic',
        sidebars = 'dark',
        floats = 'dark',
      },
      sidebars = config().theme.sidebars,
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_highlights = function(hl, c)
        hl.NotifyBackground = { bg = c.bg, fg = c.fg }
        hl.Cursor = { fg = c.black, bg = c.fg }
      end,
      on_colors = function(colors) colors.border = '#7aa2f7' end,
    }
    tokyonight.load()
  end,
}

themes.setup = function() themes[config().theme.name].set() end

themes.spec = {
  -- themes.catppuccin.spec,
  -- themes.github.spec,
  -- themes.rosepine.spec,
  themes.tokyonight.spec,
}

return themes
