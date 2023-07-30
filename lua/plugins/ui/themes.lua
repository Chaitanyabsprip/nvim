local themes = {}
local utils = require 'utils'
local config = function() return require 'plugins.ui.config' end

local t = function() return require 'plugins.ui.themes' end

local function cmp_highlight()
  local groups = {
    PmenuSel = { bg = '#282C34', fg = 'NONE' },
    Pmenu = { fg = '#C5CDD9', bg = '#22252A' },

    CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
    CmpItemAbbrMatch = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemAbbrMatchFuzzy = { fg = '#82AAFF', bg = 'NONE', bold = true },
    CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },

    CmpItemKindField = { fg = '#EED8DA', bg = '#B5585F' },
    CmpItemKindProperty = { fg = '#EED8DA', bg = '#B5585F' },
    CmpItemKindEvent = { fg = '#EED8DA', bg = '#B5585F' },

    CmpItemKindText = { fg = '#C3E88D', bg = '#9FBD73' },
    CmpItemKindEnum = { fg = '#C3E88D', bg = '#9FBD73' },
    CmpItemKindKeyword = { fg = '#C3E88D', bg = '#9FBD73' },

    CmpItemKindConstant = { fg = '#FFE082', bg = '#D4BB6C' },
    CmpItemKindConstructor = { fg = '#FFE082', bg = '#D4BB6C' },
    CmpItemKindReference = { fg = '#FFE082', bg = '#D4BB6C' },

    CmpItemKindFunction = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindStruct = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindClass = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindModule = { fg = '#EADFF0', bg = '#A377BF' },
    CmpItemKindOperator = { fg = '#EADFF0', bg = '#A377BF' },

    CmpItemKindVariable = { fg = '#C5CDD9', bg = '#7E8294' },
    CmpItemKindFile = { fg = '#C5CDD9', bg = '#7E8294' },

    CmpItemKindUnit = { fg = '#F5EBD9', bg = '#D4A959' },
    CmpItemKindSnippet = { fg = '#F5EBD9', bg = '#D4A959' },
    CmpItemKindFolder = { fg = '#F5EBD9', bg = '#D4A959' },

    CmpItemKindMethod = { fg = '#DDE5F5', bg = '#6C8ED4' },
    CmpItemKindValue = { fg = '#DDE5F5', bg = '#6C8ED4' },
    CmpItemKindEnumMember = { fg = '#DDE5F5', bg = '#6C8ED4' },

    CmpItemKindInterface = { fg = '#D8EEEB', bg = '#58B5A8' },
    CmpItemKindColor = { fg = '#D8EEEB', bg = '#58B5A8' },
    CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = '#58B5A8' },
  }
  local hl = vim.api.nvim_set_hl
  for key, value in pairs(groups) do
    hl(0, key, value)
  end
end

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
          NotifyBackground = { bg = c.base, fg = c.text },
          LeapBackdrop = { fg = '#545c7e' },
          TelescopePromptPrefix = { bg = c.surface0, fg = c.red },
          TelescopePromptNormal = { bg = c.surface0 },
          TelescopePromptBorder = { bg = c.surface0 },
          TelescopePreviewTitle = { bg = utils.darken(c.sky, 0.30, c.base), fg = c.text },
          TelescopePromptTitle = { bg = c.red, fg = c.crust },
          TelescopeResultsTitle = { bg = c.mantle, fg = c.mantle },
          TelescopeNormal = { bg = c.mantle },
          TelescopeBorder = { bg = c.mantle },
        }
      end,
      integrations = {
        dap = { enabled = true, enable_ui = true },
        gitsigns = true,
        harpoon = true,
        leap = true,
        markdown = true,
        mason = true,
        mini = true,
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        treesitter = true,
        ts_rainbow = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
  set = function() vim.cmd.colorscheme 'catppuccin' end,
}

themes.material = {
  spec = {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    config = function() t().setup() end,
  },
  setup = function()
    local colors = require 'material.colors'
    require('material').setup {
      contrast = {
        terminal = true, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        non_current_windows = true, -- Enable contrasted background for non-current windows
      },
      disable = { background = false },
      styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { italic = true },
        strings = { bold = true },
      },
      plugins = { 'dap', 'gitsigns', 'mini', 'nvim-cmp', 'nvim-navic', 'nvim-tree', 'telescope' },
      custom_highlights = {
        NotifyBackground = { bg = colors.editor.bg, fg = colors.editor.fg },
        CursorLine = { bg = '#1a1c25' },
        LeapBackdrop = { fg = '#545c7e' },
        ['@text.reference'] = { guifg = 'cyan' },
      },
    }
    vim.g.material_style = 'deep ocean'
  end,
  set = function() vim.cmd.colorscheme 'material' end,
}

themes.rosepine = {
  spec = {
    'rose-pine/neovim',
    -- 'denspiro/rose-pine',
    -- 'sindrets/rose-pine-neovim',
    name = 'rose-pine',
    config = function() t().setup() end,
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
  end,
  set = function() vim.cmd.colorscheme 'rose-pine' end,
}

themes.tokyonight = {
  spec = {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function() t().setup() end,
    -- event = 'VeryLazy',
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
  end,
  set = function() require('tokyonight').load() end,
}

themes.kanagawa = {
  spec = {
    'rebelot/kanagawa.nvim',
    lazy = false,
    config = function() t().setup() end,
  },
  setup = function()
    require('kanagawa').setup {
      -- compile = false, -- enable compiling the colorscheme
      -- undercurl = true, -- enable undercurls
      -- commentStyle = { italic = true },
      -- functionStyle = {},
      -- keywordStyle = { italic = true },
      -- statementStyle = { bold = true },
      -- typeStyle = {},
      transparent = true, -- do not set background color
      -- dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      -- terminalColors = true, -- define vim.g.terminal_color_{0,17}
      -- colors = { -- add/modify theme and palette colors
      --   palette = {},
      --   theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      -- },
      ---@diagnostic disable-next-line: unused-local
      -- overrides = function(colors) -- add/modify highlights
      --   return {}
      -- end,
      -- theme = 'dragon', -- Load "wave" theme when 'background' option is not set
      -- background = { -- map the value of 'background' option to a theme
      --   dark = 'dragon', -- try "dragon" !
      --   light = 'lotus',
      -- },
    }
  end,
  set = function() vim.cmd.colorscheme 'kanagawa' end,
}

themes.setup = function() themes[config().theme.name].set() end

themes.spec = {
  -- themes.kanagawa.spec,
  themes.catppuccin.spec,
  -- themes.rosepine.spec,
  -- themes.material.spec,
  themes.tokyonight.spec,
}

return themes
