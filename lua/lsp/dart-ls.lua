local M = {}

M.setup = function()
  require('flutter-tools').setup {
    closing_tags = { enabled = false },
    dev_tools = { autostart = true, auto_open_browser = true },
    -- debug_log = { enabled = true },
    debugger = {
      enabled = true,
      run_via_dap = true,
      register_configurations = function(_)
        require('dap').configurations.dart = {}
        require('dap.ext.vscode').load_launchjs()
      end,
    },
    flutter_path = os.getenv 'HOME' .. '/Downloads/flutter/bin/flutter',
    lsp = {
      on_attach = LSP.common_on_attach,
      capabilities = LSP.capabilities,
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
      },
      root_dir = require('lspconfig').util.root_pattern(
        '.git',
        '.gitignore',
        'pubspec.yaml',
        vim.fn.getcwd()
      ),
      settings = {
        showTodos = false,
        completeFunctionCalls = true,
        renameFilesWithClasses = true,
      },
    },
    ui = { border = 'rounded' },
    widget_guides = { enabled = false },
  }

  require('telescope').load_extension 'flutter'
  vim.api.nvim_set_keymap(
    'n',
    '<leader>fc',
    ":lua require('telescope').extensions.flutter.commands()<CR>",
    { noremap = true, silent = true }
  )
end
return M
