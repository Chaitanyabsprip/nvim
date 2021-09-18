require("flutter-tools").setup {
  -- closing_tags = {highlight = "Comment", prefix = "> // ", enabled = true},
  dev_tools = {autostart = true, auto_open_browser = true},
  debugger = {enabled = true},
  flutter_path = "/Users/chaitanyasharma/Downloads/flutter/bin/flutter",
  lsp = {
    on_attach = LSP.common_on_attach,
    capabilities = LSP.capabilities,
    init_options = {
      onlyAnalyzeProjectsWithOpenFiles = true,
      suggestFromUnimportedLibraries = true,
      closingLabels = true
    },
    root_dir = require'lspconfig'.util.root_pattern(".git", ".gitignore",
                                                    "pubspec.yaml",
                                                    vim.fn.getcwd()),
    settings = {showTodos = false, completeFunctionCalls = true}
  },
  ui = {border = "rounded"},
  widget_guides = {enabled = false}
}

require("telescope").load_extension("flutter")
vim.api.nvim_set_keymap('n', '<leader>fc',
                        ":lua require('telescope').extensions.flutter.commands()<CR>",
                        {noremap = true, silent = true})

--[[ local dart_capabilities = vim.lsp.protocol.make_client_capabilities()
dart_capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
  codeActionLiteralSupport = {
      codeActionKind = {
          valueSet = {
             "",
             "quickfix",
             "refactor",
             "refactor.extract",
             "refactor.inline",
             "refactor.rewrite",
             "source",
             "source.organizeImports",
          };
      };
  };
}
nvim_lsp.dartls.setup({
  on_attach = on_attach,
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = false,
    closingLabels = true,
  };
  capabilities = dart_capabilities;
}) ]]
