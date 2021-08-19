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
  use "Nash0x7E2/awesome-flutter-snippets"
  use {
    'NTBBloodbath/rest.nvim',
    config = function()
      require('rest-nvim').setup()
      vim.api.nvim_set_keymap("n", "<leader>rn",
                              "<cmd>lua require('rest-nvim').run()<CR>",
                              {noremap = true, silent = true})
    end
  }
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout
        act_as_tab = true, -- shift content if tab out is not possible
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          {open = "'", close = "'"}, {open = '"', close = '"'},
          {open = '`', close = '`'}, {open = '(', close = ')'},
          {open = '[', close = ']'}, {open = '{', close = '}'},
          {open = '<', close = '>'}
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = {'nvim-treesitter'}, -- or require if not used so far
    after = {'nvim-compe'} -- if a completion plugin is using tabs load it before
  }
  use {
    "ahmedkhalf/lsp-rooter.nvim",
    config = function()
      require"lsp-rooter".setup {ignore_lsp = {"efm"}}
    end
  }
  use {
    "akinsho/dependency-assist.nvim",
    config = function()
      require"dependency_assist".setup()
    end
  }
  use "akinsho/flutter-tools.nvim"
  use 'akinsho/nvim-bufferline.lua'
  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("plugins.toggleterm")
    end
  }
  use "arkav/lualine-lsp-progress"
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
  -- use {
  --   'beauwilliams/focus.nvim',
  --   config = function()
  --     local focus = require('focus')
  --     focus.enable = true
  --     focus.width = 120
  --     focus.height = 40
  --     focus.treewidth = 25
  --     focus.cursorline = true
  --     focus.signcolumn = true
  --   end
  -- }
  use { -- better surround plugin needed
    "blackCauldron7/surround.nvim",
    config = function()
      require"surround".setup {}
    end
  }
  use {
    "camspiers/snap",
    config = function()
      local snap = require 'snap'
      snap.register.map({"n"}, {"<Leader>fg"}, function()
        snap.run {
          producer = snap.get 'consumer.limit'(100000,
                                               snap.get 'producer.ripgrep.vimgrep'),
          select = snap.get'select.vimgrep'.select,
          multiselect = snap.get'select.vimgrep'.multiselect,
          views = {snap.get 'preview.vimgrep'}
        }
      end)
      snap.register.map({"n"}, {"<Leader>ff"}, function()
        snap.run {
          producer = snap.get 'consumer.fzf'(snap.get 'producer.ripgrep.file'),
          select = snap.get'select.file'.select,
          multiselect = snap.get'select.file'.multiselect,
          views = {snap.get 'preview.file'}
        }
      end)
    end
  }
  use {
    "dart-lang/dart-vim-plugin",
    config = function()
      vim.g.dart_format_on_save = 0
      vim.cmd [[let dart_html_in_string=v:true]]
    end
  }
  use "folke/lua-dev.nvim"
  use "folke/lsp-trouble.nvim"
  use {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = {"FIXME", "BUG", "FIXIT", "ISSUE", "XXX"}
          },
          TODO = {icon = " ", color = "info"},
          HACK = {icon = " ", color = "warning"},
          WARN = {icon = " ", color = "warning", alt = {"WARNING", "XXX"}},
          PERF = {icon = " ", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}},
          NOTE = {icon = " ", color = "hint", alt = {"INFO"}}
        }
      }
    end
  }
  use {
    "folke/twilight.nvim",
    cmd = {"Twilight"},
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = {"Normal", "#ffffff"},
          inactive = true
        },
        context = 10, -- amount of lines we will try to show around the current line
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function", "method", "table", "if_statement"
        },
        exclude = {} -- exclude these filetypes
      }
    end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = {kitty = {enabled = true, font = "+4"}},
        on_open = function(win)
          print("ZEN MODE")
        end,
        on_close = function()
          print("NORMAL MODE")
        end
      }
    end,
    cmd = {'ZenMode'}
  }
  use "gelguy/wilder.nvim"
  use "hrsh7th/nvim-compe"
  use "hrsh7th/vim-vsnip"
  use {"iamcco/markdown-preview.nvim", run = "cd app && yarn install"}
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use {
    "mbbill/undotree",
    config = function()
      vim.api.nvim_set_keymap('n', '<C-u>', ':UndotreeToggle<CR>',
                              {noremap = true})
    end,
    cmd = {'UndotreeToggle'}
  }
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-jdtls"
  use "mhinz/vim-startify"
  use "neovim/nvim-lspconfig"
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {}
    end
  }
  use "dstein64/vim-startuptime"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-dap.nvim"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "nvim-treesitter/nvim-treesitter-refactor"
  use {
    "onsails/lspkind-nvim",
    config = function()
      require"lspkind".init({})
    end
  }
  use "rafamadriz/friendly-snippets"
  use "ray-x/lsp_signature.nvim"
  use "rcarriga/nvim-dap-ui"
  use {
    'rcarriga/nvim-notify',
    config = function()
      ---Send a notification
      -- @param msg of the notification to show to the user
      -- @param level Optional log level
      -- @param opts Dictionary with optional options (timeout, etc)
      vim.notify = function(msg, level, opts)
        local l = vim.log.levels
        assert(type(msg) == 'string', 'msg should be a string')
        assert(type(level) ~= 'table',
               'level should be one of vim.log.levels or a string')
        opts = opts or {}
        level = level or l.INFO
        local levels = {
          [l.DEBUG] = 'Debug',
          [l.INFO] = 'Information',
          [l.WARN] = 'Warning',
          [l.ERROR] = 'Error'
        }
        opts.title = opts.title or type(level) == 'string' and level or
                         levels[level]
        local notify = require 'notify'
        notify(msg, level, opts)
      end
    end
  }
  use {
    'rhysd/conflict-marker.vim',
    config = function()
      -- require('as.highlights').plugin('conflictMarker', {
      --   'ConflictMarkerBegin', {guibg = '#2f7366'}
      -- }, {'ConflictMarkerOurs', {guibg = '#2e5049'}}, {
      --   'ConflictMarkerTheirs', {guibg = '#344f69'}
      -- }, {'ConflictMarkerEnd', {guibg = '#2f628e'}}, {
      --   'ConflictMarkerCommonAncestorsHunk', {guibg = '#754a81'}
      -- })
      -- disable the default highlight group
      vim.g.conflict_marker_highlight_group = ''
      -- Include text after begin and end markers
      vim.g.conflict_marker_begin = '^<<<<<<< .*$'
      vim.g.conflict_marker_end = '^>>>>>>> .*$'
    end
  }
  use "wbthomason/packer.nvim"
  use "windwp/lsp-fastaction.nvim"
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"

  -- ***************************      THEME      ********************************

  use "arzg/vim-substrata"
  use {
    "ayu-theme/ayu-vim",
    config = function()
      vim.g.ayucolor = "mirage"
      _G.toggle_ayucolor = function()
        if vim.g.ayucolor_num == nil then
          vim.g.ayucolor_num = 0
        end
        local colors = {'mirage', 'dark', 'light'}
        ---@diagnostic disable-next-line: undefined-field
        vim.g.colo_num = ((vim.g.colo_num % table.getn(colors)) + 1)
        vim.g.ayucolor = colors[vim.g.colo_num]
        vim.api.nvim_exec("colorscheme ayu", false)
        print(vim.g.ayucolor)
      end
    end
  }
  use {
    "dracula/vim",
    as = "dracula",
    config = function()
      vim.g.dracula_colorterm = true
    end
  }
  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      -- @usage 'base' | 'moon' | 'dawn' | 'rose-pine[-moon][-dawn]'
      vim.g.rose_pine_variant = 'base'
      vim.g.rose_pine_enable_italics = true
      vim.g.rose_pine_disable_background = false
      -- Toggle variant
      vim.api.nvim_set_keymap('n', '<c-m>',
                              [[<cmd>lua require('rose-pine.functions').toggle_variant()<cr>]],
                              {noremap = true, silent = true})
    end
  }
  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_colors = {border = "#7aa2f7", bg = "#262C3A"}
      vim.g.tokyonight_dark_float = true
      vim.g.tokyonight_dark_sidebar = true
      vim.g.tokyonight_day_brightness = 1
      vim.g.tokyonight_hide_inactive_statusline = false
      vim.g.tokyonight_italic_comments = true
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_keywords = true
      vim.g.tokyonight_italic_variables = false
      vim.g.tokyonight_sidebars = {'packer'}
      vim.g.tokyonight_style = 'night'
      vim.g.tokyonight_transparent = false
    end
  }
  use "hoob3rt/lualine.nvim"
  use "kyazdani42/blue-moon"
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
                              [[:lua require('material.functions').toggle_style(true)<CR>]],
                              {noremap = true, silent = true})
    end
  }
  use "p00f/nvim-ts-rainbow"
  use "projekt0n/github-nvim-theme"
  use "romainl/flattened"
  use {
    "shaunsingh/moonlight.nvim",
    config = function()
      vim.g.moonlight_borders = true
      vim.g.moonlight_contrast = true
      vim.g.moonlight_disable_background = false
      vim.g.moonlight_italic_comments = true
      vim.g.moonlight_italic_functions = true
      vim.g.moonlight_italic_keywords = true
      vim.g.moonlight_italic_variables = false
    end
  }
  -- ****************************************************************************
end)
