local themes = {}

themes.catppuccin = {
  plug = {
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

themes.plug = themes.catppuccin.plug
themes.setup = themes.catppuccin.setup

return themes
