local servers = {}
local lsp = require 'lsp'

servers.null = {
  plug = {
    'jose-elias-alvarez/null-ls.nvim',
    ft = { 'lua', 'fish', 'yaml' },
    config = function() require('plugins.lsp.servers').null.setup() end,
  },

  setup = function()
    local null_ls = require 'null-ls'
    local code_actions = null_ls.builtins.code_actions
    local formatting = null_ls.builtins.formatting
    local get_capabilities = require('plugins.lsp.completion').get_capabilities
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup {
      save_after_formatting = true,
      on_attach = lsp.common_on_attach,
      capabilities = get_capabilities(),
      sources = {
        code_actions.gitsigns,
        diagnostics.yamllint,
        formatting.fish_indent,
        formatting.stylua,
      },
    }
  end,
}

servers.flutter = {
  plug = {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart' },
    config = function() require('plugins.lsp.servers').flutter.setup() end,
  },

  setup = function()
    local get_capabilities = require('plugins.lsp.completion').get_capabilities
    local lspconfig = require 'lspconfig'
    require('flutter-tools').setup {
      closing_tags = { enabled = false },
      debugger = {
        enabled = false,
        run_via_dap = true,
        register_configurations = function(_)
          require('dap').adapters.dart = {
            type = 'executable',
            command = 'node',
            args = {
              '/Users/chaitanyasharma/.cache/nvim/dart-code/out/dist/debug.js',
              'flutter',
            },
          }
          require('dap').configurations.dart = {
            {
              type = 'dart',
              request = 'launch',
              name = 'Launch flutter',
              dartSdkPath = vim.fn.getcwd() .. '/.fvm/flutter_sdk/bin/cache/dart-sdk/',
              flutterSdkPath = vim.fn.getcwd() .. '/.fvm/flutter_sdk',
              program = '${workspaceFolder}/lib/main.dart',
              cwd = '${workspaceFolder}',
            },
          }
          require('dap.ext.vscode').load_launchjs()
        end,
      },
      dev_tools = { autostart = true, auto_open_browser = true },
      dev_log = { enabled = false },
      fvm = true,
      lsp = {
        color = {
          -- enabled = true,
          background = true,
          foreground = false,
          virtual_text = false,
          -- virtual_text_str = "■",
        },
        capabilities = get_capabilities(),
        on_attach = lsp.common_on_attach,
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
        },
        root_dir = lspconfig.util.root_pattern(
          '.git',
          '.gitignore',
          'pubspec.yaml',
          vim.fn.getcwd()
        ),
        settings = {
          showTodos = false,
          renameFilesWithClasses = true,
          enableSnippets = true,
        },
      },
      ui = { border = 'rounded', notification_style = 'native' },
      widget_guides = { enabled = true },
    }
    require('telescope').load_extension 'flutter'
    vim.keymap.set(
      'n',
      '<leader>F',
      ":lua require('telescope').extensions.flutter.commands()<CR>",
      { noremap = true, silent = true }
    )
  end,
}

servers.neodev = {
  plug = {
    'folke/neodev.nvim',
    config = function() require('plugins.lsp.servers').neodev.setup() end,
  },
  setup = function() require('neodev').setup {} end,
}

servers.lsp = {
  setup = function()
    for _, server in pairs(servers.lsp.configs) do
      server()
    end
  end,

  plug = {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function() require('plugins.lsp.servers').lsp.setup() end,
    dependencies = { servers.neodev.plug },
  },

  configs = {},
}

function servers.lsp.configs.lua()
  local neodev = require('plugins.lsp.servers').neodev
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  local user = vim.fn.expand '$USER'

  local sumneko_root_path = ''
  local sumneko_binary = ''

  if vim.fn.has 'mac' == 1 then
    sumneko_root_path = '/Users/' .. user .. '/Programs/lang-servers/lua-language-server'
    sumneko_binary = '/Users/'
      .. user
      .. '/Programs/lang-servers/lua-language-server/bin/lua-language-server'
  elseif vim.fn.has 'unix' == 1 then
    sumneko_root_path = vim.fn.expand '$HOME' .. '/Programs/lang-servers/lua-language-server'
    sumneko_binary = vim.fn.expand '$HOME'
      .. '/Programs/lang-servers/lua-language-server/bin/lua-language-server'
  else
    print 'Unsupported system for sumneko'
  end

  local config = {
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', '.stylua', vim.fn.getcwd()),
    capabilities = get_capabilities(),
    on_attach = lsp.common_on_attach,
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
      Lua = {
        completion = { callSnippet = 'Both' },
        diagnostics = { globals = { 'vim' } },
        telemetry = { enable = false },
      },
    },
  }
  lspconfig.sumneko_lua.setup(config)
end

servers.plug = { servers.null.plug, servers.lsp.plug, servers.flutter.plug }

return servers
