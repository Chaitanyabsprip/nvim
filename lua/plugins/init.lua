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
  use "arkav/lualine-lsp-progress"
  use "akinsho/flutter-tools.nvim"
  use {"folke/lsp-trouble.nvim"}
  use "mfussenegger/nvim-jdtls"
  use "neovim/nvim-lspconfig"
  use "nvim-lua/lsp_extensions.nvim"
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
  use {"kyazdani42/nvim-tree.lua", requires = {"kyazdani42/nvim-web-devicons"}}
  use {"nvim-telescope/telescope.nvim", requires = {"nvim-lua/plenary.nvim"}}

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - EDITING - - - - - - - - - - - - - - - - -

  use {
    "b3nj5m1n/kommentary",
    config = function()
      require"kommentary.config".configure_language("default", {
        prefer_single_line_comments = true,
        use_consistent_indentation = true,
        ignore_whitespace = true
      })
    end
  }
  use { -- better surround plugin needed
    "blackCauldron7/surround.nvim",
    config = function()
      require"surround".setup {}
    end
  }
  use {
    "mbbill/undotree",
    config = function()
      vim.api.nvim_set_keymap('n', '<C-u>', ':UndotreeToggle<CR>',
                              {noremap = true})
    end,
    cmd = {'UndotreeToggle'}
  }
  use {"windwp/nvim-autopairs"}
  use "windwp/nvim-ts-autotag"
  use "wellle/visual-split.vim"

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - - GIT - - - - - - - - - - - - - - - - - -

  -- use {'tanvirtin/vgit.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {
    "rhysd/conflict-marker.vim",
    config = function()
      -- vim.g.conflict_marker_highlight_group = ''
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = '^<<<<<<< .*$'
      vim.g.conflict_marker_end = '^>>>>>>> .*$'
    end
  }

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - - - - UTILITIES - - - - - - - - - - - - - - - -

  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
    end
  }
  use {"nicwest/vim-workman"}
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {}
    end
  }
  use {
    "nacro90/numb.nvim",
    config = function()
      require('numb').setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        number_only = false -- Peek only when the command is only a number instead of when it starts with a number
      }
    end
  }
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
    end
  }
  use {"rmagatti/auto-session", requires = {"rmagatti/session-lens"}}
  use {
    "NTBBloodbath/rest.nvim",
    config = function()
      require('rest-nvim').setup()
      vim.api.nvim_set_keymap("n", "<leader>rn",
                              "<cmd>lua require('rest-nvim').run()<CR>",
                              {noremap = true, silent = true})
    end
  }
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup({
        icons = {
          ["class-name"] = ' ', -- Classes and class-like objects
          ["function-name"] = ' ', -- Functions
          ["method-name"] = ' ' -- Methods (functions inside class-like objects)
        },
        languages = { -- You can disable any language individually here
          -- ["c"] = false,
          -- ["cpp"] = false,
          -- ["go"] = true,
          -- ["java"] = true,
          -- ["javascript"] = true,
          -- ["lua"] = true,
          -- ["python"] = true,
          -- ["rust"] = true,
          -- ["dart"] = tue
        },
        separator = ' -> '
      })
    end
  }
  use "dstein64/vim-startuptime"
  use {"folke/todo-comments.nvim"}
  use {"folke/twilight.nvim"}
  use {"folke/zen-mode.nvim"}
  use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
  use {'rcarriga/nvim-notify'}
  use {
    "romgrk/nvim-treesitter-context",
    config = function()
      require'treesitter-context'.setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true -- Throttles plugin updates (may improve performance)
      }
    end
  }
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "nvim-treesitter/nvim-treesitter-refactor"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-telescope/telescope-dap.nvim"
  use "kyazdani42/nvim-web-devicons"
  -- use {"mhinz/vim-startify"}
  -- use "jbyuki/instant.nvim"

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - COMPLETION AND SNIPPETS - - - - - - - - - - - - -

  use "Nash0x7E2/awesome-flutter-snippets"
  use "rafamadriz/friendly-snippets"
  use {"hrsh7th/nvim-compe"}
  use "hrsh7th/vim-vsnip"

  -- - - - - - - - - - - - - - - - - - XXX - - - - - - - - - - - - - - - - - -

  -- - - - - - - - - - - - - - DEVELOPMENT SPECIFIC - - - - - - - - - - - - - -
  use {
    "akinsho/dependency-assist.nvim",
    config = function()
      require"dependency_assist".setup()
    end
  }
  use "dag/vim-fish"
  use {
    "dart-lang/dart-vim-plugin",
    config = function()
      vim.g.dart_format_on_save = 0
      vim.cmd "let dart_html_in_string=v:true"
    end
  }
  use "folke/lua-dev.nvim"
  use {"mfussenegger/nvim-dap"}
  use {"michaelb/sniprun", run = "bash ./install.sh"}
  use {"pianocomposer321/yabs.nvim"}
  use "rcarriga/nvim-dap-ui"
  use {
    "rcarriga/vim-ultest",
    requires = {"vim-test/vim-test"},
    run = ":UpdateRemotePlugins",
    config = function()
      vim.g.ultest_output_on_run = 0
    end
  }
  use "wbthomason/packer.nvim"

  -- ***************************      THEME      ********************************

  -- use "arzg/vim-substrata"
  -- use {
  --   "ayu-theme/ayu-vim",
  --   config = function()
  --     vim.g.ayucolor = "mirage"
  --     _G.toggle_ayucolor = function()
  --       if vim.g.ayucolor_num == nil then
  --         vim.g.ayucolor_num = 0
  --       end
  --       local colors = {'mirage', 'dark', 'light'}
  --       ---@diagnostic disable-next-line: undefined-field
  --       vim.g.colo_num = ((vim.g.colo_num % table.getn(colors)) + 1)
  --       vim.g.ayucolor = colors[vim.g.colo_num]
  --       vim.api.nvim_exec("colorscheme ayu", false)
  --       print(vim.g.ayucolor)
  --     end
  --   end
  -- }

  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      -- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
      vim.g.rose_pine_variant = 'base'
      vim.g.rose_pine_enable_italics = true
      vim.g.rose_pine_disable_background = false
    end
  }

  -- use {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     vim.g.tokyonight_colors = {border = "#7aa2f7", bg = "#262C3A"}
  --     vim.g.tokyonight_dark_float = true
  --     vim.g.tokyonight_dark_sidebar = true
  --     vim.g.tokyonight_day_brightness = 1
  --     vim.g.tokyonight_hide_inactive_statusline = false
  --     vim.g.tokyonight_italic_comments = true
  --     vim.g.tokyonight_italic_functions = true
  --     vim.g.tokyonight_italic_keywords = true
  --     vim.g.tokyonight_italic_variables = false
  --     vim.g.tokyonight_sidebars = {'packer'}
  --     vim.g.tokyonight_style = 'night'
  --     vim.g.tokyonight_transparent = false
  --   end
  -- }

  use {"hoob3rt/lualine.nvim"}

  -- use "kyazdani42/blue-moon"

  use {
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_borders = true
      vim.g.material_contrast = true
      vim.g.material_disable_background = false
      vim.g.material_italic_comments = true
      vim.g.material_italic_functions = true
      vim.g.material_italic_keywords = true
      vim.g.material_italic_variables = false
      vim.g.material_style = 'deep ocean'

      vim.api.nvim_set_keymap('n', '<leader>m',
                              ":lua require('material.functions').toggle_style(true)<CR>",
                              {noremap = true, silent = true})
    end
  }

  use "p00f/nvim-ts-rainbow"
  -- use "projekt0n/github-nvim-theme"

  -- use {
  --   "shaunsingh/moonlight.nvim",
  --   config = function()
  --     vim.g.moonlight_borders = true
  --     vim.g.moonlight_contrast = true
  --     vim.g.moonlight_disable_background = false
  --     vim.g.moonlight_italic_comments = true
  --     vim.g.moonlight_italic_functions = true
  --     vim.g.moonlight_italic_keywords = true
  --     vim.g.moonlight_italic_variables = false
  --   end
  -- }

  -- use 'yashguptaz/calvera-dark.nvim'
  -- ****************************************************************************
end)
