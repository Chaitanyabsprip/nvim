local lsp = {}

lsp.capabilities = function(_)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  -- local completionItem = capabilities.textDocument.completion.completionItem
  -- completionItem.documentationFormat = { 'markdown', 'plaintext' }
  -- completionItem.workspaceWord = true
  return capabilities
end

lsp.common_on_attach = function(client, bufnr)
  require('lsp.diagnostics').on_attach(client, bufnr)
  require('lsp.capabilities').resolve(client, bufnr)
  require('lsp.handlers').resolve()
end

lsp.no_formatting_on_attach = function(client, bufnr)
  lsp.common_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return lsp
