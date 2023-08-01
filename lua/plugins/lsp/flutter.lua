local lsp = require 'lsp'
local M = {}

local function dap_configuration(_)
  local dap = require 'dap'
  dap.adapters.dart = {
    enrich_config = function(config, on_config) on_config(config) end,
    type = 'executable',
    command = 'flutter',
    args = { 'debug-adapter' },
  }
  dap.configurations.dart = {
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
end

function M.will_rename_files(old_name, new_name, callback)
  local params = vim.lsp.util.make_position_params()
  if not new_name then return end
  local file_change = {
    newUri = vim.uri_from_fname(new_name),
    oldUri = vim.uri_from_fname(old_name),
  }
  params.files = { file_change }
  vim.lsp.buf_request(0, 'workspace/willRenameFiles', params, function(err, result)
    if err then
      return vim.notify(err.message or 'Error on getting lsp rename results!', vim.log.levels.ERROR)
    end
    callback(result)
  end)
end

local function integrate_telescope()
  require('telescope').load_extension 'flutter'
  vim.keymap.set(
    'n',
    '<leader>f',
    ":lua require('telescope').extensions.flutter.commands()<CR>",
    { noremap = true, silent = true }
  )
end

M.config = {
  spec = {
    'akinsho/flutter-tools.nvim',
    ft = { 'dart', 'yaml' },
    opts = function()
      local get_capabilities = require('plugins.lsp.completion').get_capabilities
      local lspconfig = require 'lspconfig'
      local init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = false,
        outline = false,
        flutterOutline = false,
      }
      local root_dir =
        lspconfig.util.root_pattern('.git', '.gitignore', 'pubspec.yaml', vim.fn.getcwd())
      local settings = {
        completeFunctionCalls = true,
        enableSnippets = true,
        enableSdkFormatter = true,
        includeDependenciesInWorkspaceSymbols = false,
        renameFilesWithClasses = 'always',
        showTodos = false,
        documentation = 'full',
        updateImportsOnRename = true,
      }

      local lsp_color = {
        enabled = true,
        background = true,
        background_color = { r = 19, g = 17, b = 24, bg = '#191724' },
        foreground = false,
        virtual_text = false,
        virtual_text_str = '■',
      }

      integrate_telescope()
      local group = vim.api.nvim_create_augroup('auto fix lints', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        pattern = '*.dart',
        callback = function()
          vim.lsp.buf.code_action {
            filter = function(action) return action.title == 'Fix All' end,
            apply = true,
          }
        end,
      })

      return {
        closing_tags = { enabled = false },
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = dap_configuration,
        },
        dev_tools = { autostart = true, auto_open_browser = true },
        dev_log = { enabled = false },
        fvm = true,
        lsp = {
          color = lsp_color,
          capabilities = get_capabilities(),
          on_attach = lsp.on_attach,
          init_options = init_options,
          root_dir = root_dir,
          settings = settings,
        },
        ui = { border = 'rounded', notification_style = 'native' },
        widget_guides = { enabled = true },
      }
    end,
  },
}

return M
