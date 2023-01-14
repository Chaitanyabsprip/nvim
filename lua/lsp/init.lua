local lsp = {}
local diagnostic = require 'lsp.diagnostics'

lsp.capabilities = function(_)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  -- local completionItem = capabilities.textDocument.completion.completionItem
  -- completionItem.documentationFormat = { 'markdown', 'plaintext' }
  -- completionItem.workspaceWord = true
  return capabilities
end

lsp.common_on_attach = function(client, bufnr)
  local lsp_utils = require 'lsp.utils'
  lsp_utils.resolve_capabilities(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  lsp_utils.resolve_handlers()
end

lsp.no_formatting_on_attach = function(client, bufnr)
  lsp.common_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

return lsp
