local execute = vim.api.nvim_cmmand
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path
  })
  execute "packadd packer.nvim"
end

local packer = require("packer")
local use = packer.use
return packer.startup(function()

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - - LSP - - - - - - - - - - - - - - - - - -
  use {"akinsho/flutter-tools.nvim"}
  use {"arkav/lualine-lsp-progress"}
  use {"folke/lsp-trouble.nvim"}
  use {"jose-elias-alvarez/null-ls.nvim"}
  use {"neovim/nvim-lspconfig"}
  use {"nvim-lua/lsp_extensions.nvim"}
  use {
    "onsails/lspkind-nvim",
    config = function()
      require"lspkind".init({})
    end
  }
  use {"ray-x/lsp_signature.nvim"}
  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup {}
    end
  }
  use {"windwp/lsp-fastaction.nvim"}
  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - FILE TREE NAV - - - - - - - - - - - - - - - -
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        manual_mode = false,
        detection_methods = {"lsp", "pattern"},
        patterns = {
          "pubspec.yaml", "package.json", "config.py", "setup.py", "cargo.toml",
          "Makefile", "makefile", ".git", ".gitignore", "_darcs", ".hg", ".bzr",
          ".svn"
        },
        ignore_lsp = {"efm"},
        show_hidden = false,
        silent_chdir = false,
        datapath = vim.fn.stdpath("data")
      }
      require('telescope').load_extension('projects')
    end
  }
  use {"camspiers/snap"}
  use {"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"}
  use {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}}

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - EDITING - - - - - - - - - - - - - - - - -

  use { -- better surround plugin needed
    "blackCauldron7/surround.nvim",
    config = function()
      require"surround".setup {}
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {"windwp/nvim-autopairs"}

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - - GIT - - - - - - - - - - - - - - - - - -

  use {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"}
    -- tag = 'release' -- To use the latest release
  }
  use {
    "rhysd/conflict-marker.vim",
    config = function()
      -- vim.g.conflict_marker_highlight_group = ''
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = '^<<<<<<< .*$'
      vim.g.conflict_marker_common_ancestors = '^||||||| .*$'
      vim.g.conflict_marker_end = '^>>>>>>> .*$'
    end
  }

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - UTILITIES - - - - - - - - - - - - - - - -

  use {"akinsho/nvim-bufferline.lua"}
  use {"akinsho/nvim-toggleterm.lua"}
  use {"folke/twilight.nvim"}
  use {"folke/zen-mode.nvim"}
  use {"kyazdani42/nvim-web-devicons"}
  use {
    "matbme/JABS.nvim",
    config = function()
      local ui = vim.api.nvim_list_uis()[1]
      require'jabs'.setup {
        position = 'corner', -- center, corner
        width = 70,
        height = 10,
        border = 'single', -- none, single, double, rounded, solid, shadow, (or an array or chars)
        -- Options for preview window
        preview_position = 'bottom', -- top, bottom, left, right
        preview = {
          width = 100,
          height = 30,
          border = 'double' -- none, single, double, rounded, solid, shadow, (or an array or chars)
        },
        -- the options below are ignored when position = 'center'
        col = ui.width * 0.55, -- Window appears on the right
        row = ui.height / 2 -- Window appears in the vertical middle
      }
    end
  }
  use {
    "nathom/filetype.nvim",
    config = function()
      vim.g.did_load_filetypes = 1
    end
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {}
    end
  }
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use {"nvim-lua/plenary.nvim"}
  use {"nvim-lua/popup.nvim"}
  use {"rmagatti/auto-session", requires = {"rmagatti/session-lens"}}
  use {'rcarriga/nvim-notify'}
  use {
    "romgrk/nvim-treesitter-context",
    config = function()
      require'treesitter-context'.setup {enable = true, throttle = true}
    end
  }

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - COMPLETION AND SNIPPETS - - - - - - - - - - - - -

  use {"dmitmel/cmp-cmdline-history"}
  use {"github/copilot.vim"}
  use {"hrsh7th/cmp-emoji"}
  use {"hrsh7th/cmp-nvim-lsp"}
  use {"hrsh7th/cmp-nvim-lsp-document-symbol"}
  use {"hrsh7th/cmp-nvim-lua"}
  use {"hrsh7th/cmp-buffer"}
  use {"hrsh7th/cmp-path"}
  use {"hrsh7th/cmp-cmdline"}
  use {"hrsh7th/nvim-cmp"}
  use {"hrsh7th/cmp-vsnip"}
  use {"hrsh7th/vim-vsnip"}
  use {"lukas-reineke/cmp-rg"}
  use {"lukas-reineke/cmp-under-comparator"}
  use {"Nash0x7E2/awesome-flutter-snippets"}
  use {"rafamadriz/friendly-snippets"}

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - DEVELOPMENT SPECIFIC - - - - - - - - - - - - - -
  use {
    "akinsho/dependency-assist.nvim",
    config = function()
      require"dependency_assist".setup()
    end
  }
  use {"dag/vim-fish"}
  use {
    "dart-lang/dart-vim-plugin",
    config = function()
      vim.g.dart_format_on_save = 0
      vim.cmd "let dart_html_in_string=v:true"
    end
  }
  -- use {"folke/lua-dev.nvim"}
  use {"jparise/vim-graphql"}
  use {
    "rcarriga/vim-ultest",
    requires = {"vim-test/vim-test"},
    run = ":UpdateRemotePlugins",
    config = function()
      vim.g.ultest_output_on_run = 0
    end
  }
  use {"wbthomason/packer.nvim"}

  -- ***************************      THEME      ********************************

  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      vim.g.rose_pine_variant = 'base'
      vim.g.rose_pine_enable_italics = true
      vim.g.rose_pine_disable_background = true
    end
  }
  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_colors = {border = "#7aa2f7", bg = "#262C3A"}
      vim.g.tokyonight_dark_float = true
      vim.g.tokyonight_dark_sidebar = true
      vim.g.tokyonight_day_brightness = 0.3
      vim.g.tokyonight_hide_inactive_statusline = false
      vim.g.tokyonight_italic_comments = true
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_keywords = true
      vim.g.tokyonight_italic_variables = false
      vim.g.tokyonight_sidebars = {'packer'}
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_transparent = false
    end
  }
  use {"hoob3rt/lualine.nvim"}
  use "p00f/nvim-ts-rainbow"
  use 'yashguptaz/calvera-dark.nvim'

  -- ****************************************************************************
end)
