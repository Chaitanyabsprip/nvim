local M = {}
local lsp_utils = require 'lsp.utils'
local diagnostic = require 'lsp.diagnostic'
local cmp = require 'cmp_nvim_lsp'

M.capabilities = function(_)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem.documentationFormat = { 'markdown', 'plaintext' }
  completionItem.snippetSupport = true
  completionItem.workspaceWord = true
  completionItem.word = true
  completionItem.preselectSupport = true
  completionItem.insertReplaceSupport = true
  completionItem.labelDetailsSupport = true
  completionItem.deprecatedSupport = true
  completionItem.commitCharactersSupport = true
  completionItem.tagSupport = { valueSet = { 1 } }
  completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }
  capabilities = cmp.update_capabilities(capabilities)
  return capabilities
end

M.common_on_attach = function(client, bufnr)
  vim.schedule(function()
    lsp_utils.resolve_capabilities(client.resolved_capabilities)
  end)
  diagnostic.on_attach(client)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = { border = 'single' },
    floating_window = true,
    transparency = 20,
  }, bufnr)
end

M.nf_on_attach = function(client, bufnr)
  M.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

return M
