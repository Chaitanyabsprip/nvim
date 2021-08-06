local nvim_lsp = require('lspconfig')

nvim_lsp.jsonls.setup {
  cmd = {
    "node",
    "/home/chaitanya/.config/nvim/lang-servers/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
    "--stdio"
  },
  --[[ on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    LSP.on_attach(client, bufnr)
  end, ]]
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  root_dir = require'lspconfig'.util.root_pattern(".git", ".gitignore",
                                                  vim.fn.getcwd()),
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
      end
    }
  }
}
