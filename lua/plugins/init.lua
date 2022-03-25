local execute = vim.api.nvim_cmmand
local fn = vim.fn
local install_path1 = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local install_path2 = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if
  fn.empty(fn.glob(install_path1)) > 0
  and fn.empty(fn.glob(install_path2)) > 0
then
  print 'installing packer'
  Packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path1,
  }
  print 'packer installed'
  execute 'packadd packer.nvim'
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end
local use = packer.use

return packer.startup {
  function()
    use { -- LSP
      {
        'akinsho/flutter-tools.nvim',
        config = function()
          require('lsp.servers').dart()
        end,
        after = { 'nvim-lspconfig', 'telescope.nvim' },
      },
      {
        'folke/lsp-trouble.nvim',
        after = 'nvim-lspconfig',
        config = function()
          require('plugins.lsp').trouble()
        end,
      },
      {
        'j-hui/fidget.nvim',
        event = 'BufWinEnter',
        config = function()
          require('fidget').setup {}
        end,
      },
      { 'jose-elias-alvarez/null-ls.nvim', event = 'BufRead' },
      {
        'mfussenegger/nvim-dap',
        config = "require 'plugins.lsp.nvim-dap'",
        after = 'nvim-dap-ui',
      },
      {
        'neovim/nvim-lspconfig',
        after = { 'cmp-nvim-lsp', 'null-ls.nvim', 'lsp_signature.nvim' },
        config = function()
          require 'lsp.init'()
        end,
      },
      { 'nvim-lua/lsp_extensions.nvim', event = 'BufRead' },
      {
        'nvim-telescope/telescope-dap.nvim',
        config = "require('telescope').load_extension 'dap'",
        after = 'nvim-dap',
      },
      { 'ray-x/lsp_signature.nvim', event = 'BufRead' },
      {
        'rcarriga/nvim-dap-ui',
        after = { 'nvim-lspconfig', 'flutter-tools.nvim' },
      },
      {
        'simrat39/rust-tools.nvim',
        config = function()
          require('rust-tools').setup {}
        end,
        after = 'nvim-lspconfig',
      },
      {
        'simrat39/symbols-outline.nvim',
        config = function()
          vim.g.symbols_outline = {
            highlight_hovered_item = true,
            show_guides = true,
            auto_preview = false, -- experimental
            position = 'right',
            keymaps = {
              close = 'q',
              goto_location = '<Cr>',
              focus_location = 'o',
              hover_symbol = '<C-space>',
              rename_symbol = 'r',
              code_actions = 'a',
            },
            lsp_blacklist = {},
          }
          vim.api.nvim_set_keymap(
            'n',
            '<M-s>',
            ':SymbolsOutline<CR>',
            { noremap = true, silent = true }
          )
        end,
        cmd = { 'SymbolsOutline' },
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = "require('nvim-dap-virtual-text').setup()",
        after = 'nvim-dap',
      },
      {
        'windwp/lsp-fastaction.nvim',
        config = function()
          require('plugins.lsp').fastaction()
        end,
        after = 'nvim-lspconfig',
      },
    }

    use { -- FILE TREE NAV
      { -- project.nvim
        'ahmedkhalf/project.nvim',
        config = require('plugins.explorer').project,
        after = 'telescope.nvim',
      },
      {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
          require('plugins.explorer').nvim_tree()
        end,
      },
      {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require 'plugins.explorer'.telescope()",
        event = 'BufWinEnter',
      },
      {
        'nvim-telescope/telescope-file-browser.nvim',
        config = function()
          require('plugins.nvim.file_browser').setup()
        end,
        after = 'telescope.nvim',
      },
    }

    use { -- EDITING
      {
        'Mephistophiles/surround.nvim',
        config = function()
          require('surround').setup {}
        end,
        event = 'BufWinEnter',
      },
      {
        'numToStr/Comment.nvim',
        config = function()
          require('Comment').setup()
        end,
        event = 'BufWinEnter',
      },
      {
        'windwp/nvim-autopairs',
        config = function()
          require('plugins.editing').autopairs()
        end,
        after = 'nvim-cmp',
      },
    }

    use { -- GIT
      {
        'rhysd/conflict-marker.vim',
        config = function()
          vim.g.conflict_marker_begin = '^<<<<<<< .*$'
          vim.g.conflict_marker_common_ancestors = '^||||||| .*$'
          vim.g.conflict_marker_end = '^>>>>>>> .*$'
          vim.cmd [[
        highlight link ConflictMarkerOurs DiagnosticVirtualTextHint
        highlight ConflictMarkerBegin guibg=#2f7366
        highlight ConflictMarkerOurs guibg=#2e5049
        highlight ConflictMarkerTheirs guibg=#344f69
        highlight ConflictMarkerEnd guibg=#2f628e
        highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
      ]]
        end,
        event = 'BufWinEnter',
      },
      {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require 'plugins.git.gitsigns'",
        event = 'BufRead',
      },
    }

    use { -- COMPLETION AND SNIPPETS
      { -- flutter-snippets
        'Alexisvt/flutter-snippets',
        ft = { 'dart' },
        after = 'flutter-tools.nvim',
      },
      { 'Nash0x7E2/awesome-flutter-snippets', after = 'flutter-tools.nvim' },
      { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
      { 'github/copilot.vim', event = 'BufWinEnter' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', event = 'BufWinEnter' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      {
        'hrsh7th/nvim-cmp',
        config = "require 'plugins.lsp.nvim-cmp'",
        event = { 'InsertEnter', 'CmdlineEnter' },
      },
      { 'hrsh7th/vim-vsnip', after = 'nvim-cmp' },
      { 'rafamadriz/friendly-snippets', after = 'nvim-cmp' },
    }

    use { -- UTILITIES
      {
        '~/Projects/Languages/Lua/present.nvim',
        -- ft = { 'markdown' },
        cmd = { 'Present', 'PresentEnable', 'PresentDisable' },
        config = function()
          require('present').setup()
        end,
      },
      { -- highlight
        'Pocco81/HighStr.nvim',
        config = require('plugins.utilities').highlight,
        event = 'BufWinEnter',
      },
      {
        'rcarriga/nvim-notify',
        config = function()
          require 'plugins.nvim.notify'
        end,
        event = 'BufWinEnter',
      },
      {
        'akinsho/nvim-bufferline.lua',
        config = "require 'plugins.nvim.nvim-bufferline'",
      },
      { -- toggleterm
        'akinsho/nvim-toggleterm.lua',
        config = function()
          require('plugins.toggleterm').setup()
        end,
        keys = {
          { 'n', '<leader>tf' },
          { 'n', '<leader>tg' },
          { 'n', '<leader>tt' },
          { 'n', '<leader>tr' },
        },
        cmd = 'ToggleTerm',
      },
      {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        config = [[vim.g.startuptime_tries = 15]],
      },
      {
        'jakewvincent/mkdnflow.nvim',
        ft = { 'markdown', 'md', 'rmd' },
        config = function()
          require('mkdnflow').setup {
            default_mappings = true,
            create_dirs = true,
            links_relative_to = 'current',
            filetypes = { md = true, rmd = true, markdown = true },
            evaluate_prefix = true,
            -- new_file_prefix = [[os.date('%Y-%m-%d_')]],
            new_file_prefix = 'n',
            -- Type: boolean. When true and Mkdnflow is searching for the next/previous
            --     link in the file, it will wrap to the beginning of the file (if it's
            --     reached the end) or wrap to the end of the file (if it's reached the
            --     beginning during a backwards search).
            wrap_to_beginning = false,
            wrap_to_end = false,
          }
        end,
      },
      {
        'jbyuki/venn.nvim',
        config = function()
          require('plugins.utilities').venn()
        end,
        ft = { 'markdown' },
      },
      { 'kyazdani42/nvim-web-devicons', event = 'BufWinEnter' },
      { -- renamer
        'filipdutescu/renamer.nvim',
        branch = 'master',
        config = "require 'plugins.lsp'.renamer()",
        requires = { 'nvim-lua/plenary.nvim' },
        after = 'nvim-lspconfig',
      },
      {
        'folke/todo-comments.nvim',
        config = require('plugins.utilities').todo_comments,
        event = 'BufWinEnter',
      },
      { -- twilight
        'folke/twilight.nvim',
        config = require('plugins.utilities').twilight,
        cmd = { 'Twilight', 'TwilightEnable' },
      },
      { -- which-key
        'folke/which-key.nvim',
        config = require('plugins.utilities').which_key,
        event = 'BufWinEnter',
      },
      { -- zen-mode
        'folke/zen-mode.nvim',
        config = require('plugins.utilities').zen_mode,
        keys = '<leader>z',
        cmd = 'ZenMode',
      },
      { 'lewis6991/impatient.nvim', event = 'BufWinEnter' },
      { 'lewis6991/spellsitter.nvim', ft = { 'markdown', 'txt' } },
      { -- filetype
        'nathom/filetype.nvim',
        config = function()
          vim.g.did_load_filetypes = 1
        end,
      },
      { -- colorizer
        'afonsocraposo/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup {
            dart = { rgb_0x = true },
          }
        end,
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
        disable = false,
      },
      { -- treesitter
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        event = 'BufReadPost',
        config = "require 'plugins.nvim-treesitter'",
      },
      { 'nvim-lua/popup.nvim' },
      {
        'olimorris/persisted.nvim',
        config = "require 'plugins.nvim.persisted'",
        disable = false,
      },
      { -- hop
        'phaazon/hop.nvim',
        as = 'hop',
        event = 'BufRead',
        config = function()
          require('plugins.editing').hop()
        end,
      },
    }

    use { -- LANGUAGE SPECIFIC
      { -- REST
        'NTBBloodbath/rest.nvim',
        ft = { 'http', 'https' },
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('rest-nvim').setup {
            result_split_horizontal = true,
            skip_ssl_verification = false,
            highlight = {
              enabled = true,
              timeout = 150,
            },
            result = {
              show_url = true,
              show_http_info = true,
              show_headers = true,
            },
            jump_to_request = true,
            env_file = '.env',
            custom_dynamic_variables = {},
            yank_dry_run = true,
          }
          local nnoremap = require('utils').nnoremap
          nnoremap('<A-r>', ':<Plug>RestNvim<cr>')
          nnoremap('<A-l>', ':<Plug>RestNvimLast<cr>')
          nnoremap('<A-s-r>', ':<Plug>RestNvimPreview<cr>')
        end,
      },
      { -- dart-code
        vim.fn.stdpath 'cache' .. '/dart-code',
        ft = { 'dart' },
        after = 'flutter-tools.nvim',
      },
      { 'Dart-Code/Flutter', ft = { 'dart' } },
      { -- dependency-assist
        'akinsho/dependency-assist.nvim',
        config = function()
          require('dependency_assist').setup()
        end,
        ft = 'yaml',
        after = 'flutter-tools.nvim',
      },
      { -- schemastore
        'b0o/SchemaStore.nvim',
        event = 'BufWinEnter',
      },
      { 'dag/vim-fish', ft = 'fish' },
      { -- dart-vim
        'dart-lang/dart-vim-plugin',
        config = require('languages').dart,
        ft = { 'dart' },
      },
      { -- lua-dev
        'folke/lua-dev.nvim',
        after = 'nvim-lspconfig',
        config = function()
          require('lsp.servers').lua()
        end,
      },
      { -- markdown-preview
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = 'markdown',
      },
      { 'jparise/vim-graphql', ft = 'graphql' },
      { 'natebosch/dartlang-snippets', ft = 'dart' },
      {
        'rcarriga/vim-ultest',
        requires = {
          'vim-test/vim-test',
          -- 'tpope/vim-dispatch',
          -- 'radenling/vim-dispatch-neovim',
          'skywind3000/asyncrun.vim',
        },
        run = ':UpdateRemotePlugins',
        config = function()
          require 'plugins.test'
        end,
      },
      { -- vim-markdown
        'plasticboy/vim-markdown',
        requires = {
          {
            'godlygeek/tabular',
            ft = 'markdown',
            event = 'BufWinEnter',
          },
        },
        ft = 'markdown',
        config = require('languages').markdown,
      },
      { 'wbthomason/packer.nvim' },
    }

    use { -- THEME
      {
        vim.fn.expand '~' .. '/Projects/Languages/Lua/arch.nvim',
        event = 'BufEnter',
      },
      { 'EdenEast/nightfox.nvim', event = 'BufEnter' },
      { 'IMOKURI/line-number-interval.nvim', event = 'BufWinEnter' },
      { 'Yagua/nebulous.nvim', event = 'BufEnter' },
      { 'bluz71/vim-moonfly-colors', event = 'BufEnter' },
      { 'bluz71/vim-nightfly-guicolors', event = 'BufEnter' },
      { 'catppuccin/nvim', as = 'catppuccin', event = 'BufEnter' },
      { 'folke/tokyonight.nvim', event = 'BufEnter' },
      { 'hoob3rt/lualine.nvim', event = 'BufEnter' },
      { 'kyazdani42/blue-moon', event = 'BufEnter' },
      { 'marko-cerovac/material.nvim', event = 'BufEnter' },
      { 'numToStr/Sakura.nvim', event = 'BufEnter' },
      { 'nxvu699134/vn-night.nvim', event = 'BufEnter' },
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter', disable = true },
      { 'projekt0n/github-nvim-theme', event = 'BufEnter' },
      { 'rafamadriz/neon', event = 'BufEnter' },
      { 'rebelot/kanagawa.nvim', event = 'BufEnter' },
      { 'rose-pine/neovim', as = 'rose-pine', event = 'BufEnter' },
      { 'shaunsingh/moonlight.nvim', event = 'BufEnter' },
      { 'yashguptaz/calvera-dark.nvim', event = 'BufEnter' },
    }
  end,
  config = {
    max_jobs = 60,
    auto_clean = true,
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  },
}
