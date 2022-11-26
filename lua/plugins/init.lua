local execute = vim.api.nvim_cmmand
local fn = vim.fn
local install_path1 = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local install_path2 = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path1)) > 0
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
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = "require('lsp_lines').setup()",
        after = { 'nvim-lspconfig' },
      },
      {
        'akinsho/flutter-tools.nvim',
        config = "require('lsp.servers').dart()",
        ft = { 'dart' },
        after = { 'cmp-nvim-lsp', 'telescope.nvim' },
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        after = { 'nvim-lspconfig' },
        event = 'BufReadPost',
        config = "require('lsp.servers').null()",
      },
      {
        'leoluz/nvim-dap-go',
        after = { 'nvim-dap' },
        config = "require('plugins.lsp.dap').go()",
      },
      {
        'mfussenegger/nvim-dap-python',
        after = { 'nvim-dap' },
        ft = 'python',
        config = "require('plugins.lsp.dap').python()",
      },

      {
        'mfussenegger/nvim-dap',
        config = "require 'plugins.lsp.nvim-dap'",
        keys = {
          { 'n', '<leader>c' },
          { 'n', '<leader>b' },
          { 'n', '<leader>B' },
          { 'n', '<leader>gt' },
        },
      },
      {
        'neovim/nvim-lspconfig',
        after = { 'cmp-nvim-lsp' },
        config = "require('lsp').init()",
      },
      {
        'nvim-telescope/telescope-dap.nvim',
        config = "require('telescope').load_extension 'dap'",
        after = { 'nvim-dap', 'telescope.nvim' },
      },
      {
        'ray-x/go.nvim',
        config = "require('lsp.servers').golang()",
        after = 'nvim-lspconfig',
        disable = true,
      },
      { 'ray-x/lsp_signature.nvim', event = 'BufRead', disable = true },
      {
        'rcarriga/nvim-dap-ui',
        config = "require('plugins.lsp.dap').ui()",
        event = 'BufWinEnter',
      },
      {
        'simrat39/rust-tools.nvim',
        config = "require('rust-tools').setup{}",
        after = 'nvim-lspconfig',
        disable = true,
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        config = "require('nvim-dap-virtual-text').setup()",
        after = 'nvim-dap',
      },
      {
        'windwp/lsp-fastaction.nvim',
        config = "require('plugins.lsp').fastaction()",
        after = 'nvim-lspconfig',
      },
    }

    use { -- FILE TREE NAV
      {
        'ahmedkhalf/project.nvim',
        config = "require('plugins.explorer').project()",
        after = 'telescope.nvim',
      },
      {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = "require('plugins.explorer').nvim_tree()",
        keys = { { 'n', '<leader>e' } },
      },
      {
        'nvim-telescope/telescope-file-browser.nvim',
        config = "require('plugins.nvim.file_browser').setup()",
        after = 'telescope.nvim',
      },
      {
        'nvim-telescope/telescope.nvim',
        requires = {
          { 'nvim-lua/plenary.nvim' },
          { 'nvim-lua/popup.nvim', event = 'BufWinEnter' },
        },
        config = "require('plugins.telescope').setup()",
        cmd = 'Telescope',
        event = 'WinEnter',
      },
    }

    use { -- EDITING
      {
        'ThePrimeagen/refactoring.nvim',
        requires = {
          { 'nvim-lua/plenary.nvim' },
          { 'RobertBrunhage/nvim-treesitter' },
        },
        config = "require('refactoring').setup({})",
        event = 'BufWinEnter',
        disable = true,
      },
      {
        'numToStr/Comment.nvim',
        config = "require('Comment').setup()",
        event = 'BufWinEnter',
      },
      {
        'ur4ltz/surround.nvim',
        config = "require('surround').setup {}",
        event = 'BufWinEnter',
      },
      {
        'windwp/nvim-autopairs',
        config = "require('plugins.editing').autopairs()",
        after = 'nvim-cmp',
      },
    }

    use { -- GIT
      {
        'ThePrimeagen/git-worktree.nvim',
        config = "require('plugins.git').git_worktree()",
        after = { 'telescope.nvim' },
      },
      {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require 'plugins.git.gitsigns'",
        event = 'BufRead',
      },
    }

    use { -- COMPLETION AND SNIPPETS
      {
        'Alexisvt/flutter-snippets',
        ft = { 'dart' },
        after = 'flutter-tools.nvim',
      },
      {
        'Nash0x7E2/awesome-flutter-snippets',
        ft = { 'dart' },
        after = 'flutter-tools.nvim',
      },
      {
        'RobertBrunhage/flutter-riverpod-snippets',
        ft = { 'dart' },
        after = 'flutter-tools.nvim',
      },
      { 'dmitmel/cmp-cmdline-history', after = 'nvim-cmp' },
      { 'dmitmel/cmp-digraphs', after = 'nvim-cmp', ft = 'markdown' },
      {
        'github/copilot.vim',
        event = 'BufWinEnter',
        commit = '042543ffc2e77a819da0415da1af6b1842a0f9c2',
      },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', event = 'BufReadPost' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      {
        'hrsh7th/nvim-cmp',
        config = "require 'plugins.lsp.nvim-cmp'",
        after = 'LuaSnip',
      },
      {
        'L3MON4D3/LuaSnip',
        tag = 'v1.*',
        event = { 'VimEnter' },
        config = "require('plugins.lsp.luasnip').setup()",
        requires = { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      },
      {
        'hrsh7th/vim-vsnip',
        after = 'nvim-cmp',
        disable = true,
        requires = { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp', disable = true },
      },
      { 'natebosch/dartlang-snippets', ft = 'dart' },
      { 'rafamadriz/friendly-snippets', after = 'nvim-cmp' },
    }

    use { -- UTILITIES
      {
        '~/Projects/Languages/Lua/obsidian.nvim',
        config = function()
          vim.keymap.set(
            'n',
            '<leader>o',
            require('obsidian').jump_to_link,
            { noremap = true, silent = true }
          )
        end,
        ft = 'markdown',
      },
      {
        '~/Projects/Languages/Lua/present.nvim',
        cmd = { 'Present', 'PresentEnable', 'PresentDisable' },
        config = "require('present').setup()",
      },
      {
        'akinsho/bufferline.nvim',
        config = "require 'plugins.nvim.nvim-bufferline'",
        event = 'BufWinEnter',
      },
      {
        'stevearc/dressing.nvim',
        after = { 'telescope.nvim' },
        config = function()
          require('dressing').setup {
            input = { prefer_width = 30 },
          }
        end,
      },
      {
        'startup-nvim/startup.nvim',
        requires = {
          'nvim-telescope/telescope.nvim',
          'nvim-lua/plenary.nvim',
        },
        config = "require('plugins.nvim.startup').setup()",
      },
      {
        'akinsho/toggleterm.nvim',
        config = "require('plugins.toggleterm').setup()",
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
        config = [[vim.g.startuptime_tries = 50]],
      },
      {
        'jbyuki/venn.nvim',
        config = "require('plugins.utilities').venn()",
        ft = { 'markdown' },
      },
      { 'kyazdani42/nvim-web-devicons', event = 'BufWinEnter' },
      {
        'folke/zen-mode.nvim',
        config = "require('plugins.utilities').zen_mode()",
        keys = { { 'n', '<leader>z' } },
        cmd = 'ZenMode',
      },
      {
        'lewis6991/impatient.nvim',
        config = "require('impatient')",
        event = 'BufWinEnter',
      },
      { 'lewis6991/spellsitter.nvim', ft = { 'markdown', 'txt' } },
      {
        'nathom/filetype.nvim',
        config = 'vim.g.did_load_filetypes = 1',
      },
      { -- colorizer
        'afonsocraposo/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup {
            dart = { rgb_0x = true },
          }
        end,
        cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
      },
      {
        'RobertBrunhage/nvim-treesitter',
        run = ':TSUpdate',
        event = 'BufReadPost',
        config = "require 'plugins.nvim-treesitter'",
      },
      {
        'phaazon/hop.nvim',
        as = 'hop',
        event = 'BufRead',
        config = "require('plugins.editing').hop()",
      },
      {
        'rmagatti/auto-session',
        config = "require 'plugins.nvim.auto-session'",
        event = 'BufWinEnter',
      },
      {
        'rmagatti/session-lens',
        config = "require 'plugins.nvim.session-lens'",
        after = { 'auto-session', 'telescope.nvim' },
      },
    }

    use { -- LANGUAGE SPECIFIC
      {
        'NTBBloodbath/rest.nvim',
        ft = { 'http', 'https' },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
          require('rest-nvim').setup {
            result_split_horizontal = false,
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
          nnoremap('<A-r>', '<Plug>RestNvim')
          nnoremap('<A-l>', 'RestNvimLast')
          nnoremap('<A-s-r>', 'RestNvimPreview')
        end,
      },
      -- {
      --  'akinsho/dependency-assist.nvim',
      --   config = "require('dependency_assist').setup()",
      --   ft = 'yaml',
      --   after = 'flutter-tools.nvim',
      -- },
      {
        'b0o/SchemaStore.nvim',
        event = 'BufWinEnter',
      },
      { 'dag/vim-fish', ft = 'fish' },
      {
        'dart-lang/dart-vim-plugin',
        config = "require('languages').dart()",
        ft = { 'dart' },
      },
      {
        'folke/lua-dev.nvim',
        after = 'nvim-lspconfig',
        config = "require('lsp.servers').lua()",
      },
      {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = 'markdown',
      },
      { 'jparise/vim-graphql', ft = 'graphql' },
      { 'mfussenegger/nvim-jdtls' },
      -- {
      -- 'nvim-neotest/neotest',
      -- requires = {
      -- {
      -- 'vim-test/vim-test',
      -- event = 'BufWinEnter',
      -- commit = '9bd4cd2d772018087d016fa4d35c45c09f13effd',
      -- },
      -- { 'nvim-neotest/neotest-vim-test', event = 'BufWinEnter' },
      -- { 'nvim-neotest/neotest-python', event = 'BufWinEnter' },
      -- { 'nvim-neotest/neotest-go', event = 'BufWinEnter' },
      -- { 'haydenmeade/neotest-jest', event = 'BufWinEnter' },
      -- { 'antoinemadec/FixCursorHold.nvim', event = 'BufWinEnter' },
      -- { 'skywind3000/asyncrun.vim', event = 'BufWinEnter' },
      -- },
      -- config = function()
      -- require('neotest').setup {
      -- adapters = {
      -- require 'neotest-vim-test' {
      --   ignore_filetypes = {
      --     'python',
      --     'lua',
      --     'javascript',
      --   },
      -- },
      -- require 'neotest-python' {
      -- runner = 'pytest',
      -- },
      -- require 'neotest-go'(),
      -- require 'neotest-jest' {},
      -- },
      -- }
      -- end,
      -- after = {
      -- 'neotest-vim-test',
      -- 'neotest-python',
      -- 'neotest-go',
      -- 'neotest-jest',
      -- 'FixCursorHold.nvim',
      -- 'asyncrun.vim',
      -- },
      -- },
      { -- vim-markdown
        'plasticboy/vim-markdown',
        requires = {
          {
            'godlygeek/tabular',
            ft = 'markdown',
            event = 'BufWinEnter',
          },
        },
        ft = { 'markdown' },
        config = "require('languages').markdown()",
      },
      { 'wbthomason/packer.nvim' },
    }

    use { -- THEME
      -- { 'EdenEast/nightfox.nvim', event = 'BufEnter' },
      -- { 'IMOKURI/line-number-interval.nvim', event = 'BufWinEnter' },
      -- { 'Yagua/nebulous.nvim', event = 'BufEnter' },
      -- { 'bluz71/vim-moonfly-colors', event = 'BufEnter' },
      -- { 'bluz71/vim-nightfly-guicolors', event = 'BufEnter' },
      { 'catppuccin/nvim', as = 'catppuccin', event = 'BufEnter' },
      -- { 'folke/tokyonight.nvim', event = 'BufEnter' },
      { 'hoob3rt/lualine.nvim', event = 'BufEnter' },
      -- { 'marko-cerovac/material.nvim', event = 'BufEnter' },
      -- { 'numToStr/Sakura.nvim', event = 'BufEnter' },
      -- { 'nxvu699134/vn-night.nvim', event = 'BufEnter' },
      -- { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter', disable = true },
      -- { 'projekt0n/github-nvim-theme', event = 'BufEnter' },
      -- { 'rafamadriz/neon', event = 'BufEnter' },
      -- { 'rebelot/kanagawa.nvim', event = 'BufEnter' },
      -- { 'rose-pine/neovim', as = 'rose-pine', event = 'BufEnter' },
      -- { 'shaunsingh/moonlight.nvim', event = 'BufEnter' },
      -- { 'yashguptaz/calvera-dark.nvim', event = 'BufEnter' },
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
