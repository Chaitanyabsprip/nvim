local nvim_lsp = require('lspconfig')

nvim_lsp.clangd.setup {
  cmd = {
    "clangd"
    -- "--background-index"
  },

  -- filetype = {"c", "cpp", "objc", "objcpp"},

  --[[ handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = O.clang.diagnostics.virtual_text,
            signs = O.clang.diagnostics.signs,
            underline = O.clang.diagnostics.underline,
          update_in_insert = true

        })
  }, ]]

  on_attach = LSP.common_on_attach
  --[[ on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    LSP.on_attach()
  end ]]
}
