local themes = {}
local config = require 'plugins.ui.config'

themes.blue_moon = {
  spec = {
    'kyazdani42/blue-moon',
    config = function() require('plugins.ui.themes').blue_moon.setup() end,
    lazy = false,
  },
  setup = function() vim.cmd.colorscheme 'blue-moon' end,
}

themes.calvera = {
  spec = {
    'yashguptaz/calvera-dark.nvim',
    config = function() require('plugins.ui.themes').calvera.setup() end,
    lazy = false,
  },
  setup = function()
    vim.g.calvera_italic_comments = config.theme.italics.comments
    vim.g.calvera_italic_keywords = config.theme.italics.keywords
    vim.g.calvera_italic_functions = config.theme.italics.functions
    vim.g.calvera_italic_variables = config.theme.italics.variables
    vim.g.calvera_borders = true
    vim.g.calvera_contrast = true
    vim.g.calvera_hide_eob = true
    vim.g.calvera_disable_background = config.theme.transparent
    vim.g.transparent_bg = config.theme.transparent
    require('calvera').set()
  end,
}

themes.catppuccin = {
  spec = {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function() require('plugins.ui.themes').setup() end,
    lazy = false,
  },
  setup = function()
    require('catppuccin').setup {
      flavor = 'mocha',
      term_colors = true,
      integrations = {
        treesitter = true,
        gitsigns = true,
        telescope = true,
        nvimtree = { enabled = true, show_root = true },
        markdown = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}

themes.material = {
  spec = {
    'marko-cerovac/material.nvim',
    config = function() require('plugins.ui.themes').material.setup() end,
    lazy = false,
  },
  setup = function()
    vim.g.material_style = 'deep ocean'
    require('material').setup {
      contrast = {
        popup_menu = true,
        sidebars = true,
        floating_windows = true,
        cursor_line = true,
      },
      italics = {
        comments = true,
        keywords = true,
        functions = true,
        variables = true,
      },
      contrast_filetypes = config.theme.sidebars,
      disable = {
        eob_lines = config.theme.hide_eob,
        background = config.theme.transparent,
      },
    }
    vim.cmd [[ colorscheme material ]]
  end,
}

themes.rosepine = {
  spec = {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function() require('plugins.ui.themes').rosepine.setup() end,
    lazy = false,
  },
  setup = function()
    vim.g.rose_pine_variant = 'base'
    vim.g.rose_pine_enable_italics = true
    vim.g.rose_pine_disable_background = config.theme.transparent
    vim.cmd.colorscheme 'rose-pine'
  end,
}

themes.sakura = {
  spec = {
    'numToStr/Sakura.nvim',
    config = function() require('plugins.ui.themes').sakura.setup() end,
    lazy = false,
  },
  setup = function()
    local sakura = require 'sakura'
    sakura.setup {
      variant = 'moon',
      transparent = config.theme.transparent,
      italics = true,
    }
    sakura.load()
  end,
}

themes.tokyonight = {
  spec = {
    'folke/tokyonight.nvim',
    config = function() require('plugins.ui.themes').tokyonight.setup() end,
    lazy = false,
  },
  setup = function()
    local tokyonight = require 'tokyonight'
    tokyonight.setup {
      style = 'night',
      transparent = config.theme.transparent,
      terminal_colors = true,
      styles = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'italic',
        variables = 'italic',
        sidebars = 'dark',
        floats = 'dark',
      },
      sidebars = config.theme.sidebars,
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors) colors.border = '#7aa2f7' end,
    }
    tokyonight.load()
  end,
}

themes.theme = themes.tokyonight
themes.spec = themes.theme.spec
themes.setup = themes.theme.setup

return themes
