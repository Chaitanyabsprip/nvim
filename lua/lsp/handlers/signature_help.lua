return {
  handler_name = 'textDocument/signatureHelp',
  handler = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded', focusable = false }
  ),
}
