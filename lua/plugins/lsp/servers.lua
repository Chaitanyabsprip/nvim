local servers = {}
local lsp = require 'lsp'

local function extend(config)
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'
  local defaults = {
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', vim.fn.getcwd()),
  }
  local updated_config = vim.tbl_deep_extend('keep', config, defaults)
  return updated_config
end

servers.null = {
  spec = {
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
    local refactoring_opts = {
      filetypes = { 'go', 'javascript', 'typescript', 'lua', 'python', 'c', 'cpp' },
    }

    null_ls.setup {
      save_after_formatting = true,
      on_attach = lsp.common_on_attach,
      capabilities = get_capabilities(),
      sources = {
        code_actions.refactoring.with(refactoring_opts),
        code_actions.gitsigns,
        diagnostics.yamllint,
        formatting.fish_indent,
        formatting.stylua,
      },
    }
    require 'mason-null-ls'
  end,
}

servers.flutter = {
  spec = {
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

servers.__neodev = {
  spec = { 'folke/neodev.nvim', config = function() require('neodev').setup {} end },
}

servers.lsp = {
  setup = function()
    for _, server in pairs(servers.lsp.configs) do
      server()
    end
  end,

  spec = {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = function()
      require 'mason-lspconfig'
      require('plugins.lsp.servers').lsp.setup()
    end,
    dependencies = { servers.__neodev.spec },
  },

  configs = {},
}

servers.__schemastore = { spec = { 'b0o/schemastore.nvim', ft = 'json' } }

function servers.lsp.configs.lua()
  local get_capabilities = require('plugins.lsp.completion').get_capabilities
  local lspconfig = require 'lspconfig'

  local config = {
    root_dir = lspconfig.util.root_pattern('.git', '.gitignore', '.stylua', vim.fn.getcwd()),
    on_attach = lsp.common_on_attach,
    capabilities = get_capabilities(),
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

function servers.lsp.configs.json()
  local lspconfig = require 'lspconfig'
  local config = extend {
    settings = { json = { schemas = require('schemastore').json.schemas() } },
    commands = {
      Format = { function() vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line '$', 0 }) end },
    },
  }
  vim.pretty_print(config)
  lspconfig.jsonls.setup(config)
end

servers.spec = {
  servers.null.spec,
  servers.lsp.spec,
  servers.flutter.spec,
  servers.__schemastore.spec,
  servers.__neodev.spec,
}

return servers
