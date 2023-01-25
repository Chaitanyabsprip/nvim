local M = {}
local mappings = require 'mappings.hashish'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap
local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
local autocmd = function(event, opts)
  if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
end
local opts = function(bufnr) return { bufnr = bufnr, silent = true } end
local lsp = vim.lsp.buf

M.code_action = {
  name = 'textDocument/codeAction',
  callback = function(_, bufnr)
    nnoremap '<leader>a'(require('lsp-fastaction').code_action)(opts(bufnr)) 'Show code actions for the current cursor position'
    vnoremap '<leader>a' '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>'(
      opts(bufnr)
    ) 'Show code actions for the current selection range'
  end,
}

M.code_lens = {
  name = 'textDocument/codeLens',
  callback = function(_, bufnr)
    autocmd({ 'BufEnter, InsertLeave, BufWritePost', 'CursorHold' }, {
      group = augroup 'lsp_codelens_refresh',
      buffer = bufnr,
      callback = function() vim.lsp.codelens.refresh() end,
    })
  end,
}

M.declaration = {
  name = 'textDocument/declaration',
  callback = function(_, bufnr)
    nnoremap 'gD'(lsp.declaration)(opts(bufnr)) 'Go to declaration of symbol under cursor'
  end,
}

M.formatting = {
  name = 'textDocument/formatting',
  callback = function(_, bufnr)
    autocmd('BufWritePre', {
      group = augroup 'auto_format',
      buffer = bufnr,
      callback = function() lsp.format() end,
    })
  end,
}

M.document_highlight = {
  name = 'textDocument/documentHighlight',
  callback = function()
    vim.schedule(function()
      local hl = vim.api.nvim_set_hl
      local folded = { link = 'Folded' }
      hl(0, 'LspReferenceRead', folded)
      hl(0, 'LspReferenceText', folded)
      hl(0, 'LspReferenceWrite', folded)
      local underline = { underline = true, bg = 'none' }
      hl(0, 'LspReferenceRead', underline)
      hl(0, 'LspReferenceText', underline)
      hl(0, 'LspReferenceWrite', underline)
    end)
  end,
}

M.range_formatting = {
  name = 'textDocument/rangeFormatting',
  callback = function() end,
}

M.document_symbols = {
  name = 'textDocument/documentSymbol',
  callback = function(_, bufnr)
    vim.notify('document', vim.log.levels.INFO)
    nnoremap 'gs'(function() lsp.document_symbol() end)(opts(bufnr)) 'View document symbols'
  end,
}

M.references = {
  name = 'textDocument/references',
  callback = function(_, bufnr)
    nnoremap 'gR'(lsp.references)(opts(bufnr)) 'Find references of symbol under cursor'
  end,
}

M.definition = {
  name = 'textDocument/definition',
  callback = function(_, bufnr)
    nnoremap 'gd'(lsp.definition)(opts(bufnr)) 'Go to definition of symbol under cursor'
  end,
}

M.hover = {
  name = 'textDocument/hover',
  callback = function(_, bufnr)
    nnoremap 'K'(lsp.hover)(opts(bufnr)) 'Show hover info of symbol under cursor'
  end,
}

M.implementation = {
  name = 'textDocument/implementation',
  callback = function(_, bufnr)
    nnoremap 'gi'(lsp.implementation)(opts(bufnr)) 'Show implementations of symbol under cursor'
  end,
}

M.rename = {
  name = 'textDocument/rename',
  callback = function(_, bufnr)
    nnoremap 'gr'(function() vim.ui.input({ prompt = 'Rename: ' }, lsp.rename) end)(opts(bufnr)) 'Rename symbol under cursor'
  end,
}

M.signature_help = {
  name = 'textDocument/signatureHelp',
  callback = function() end,
}

M.type_definition = {
  name = 'textDocument/typeDefinition',
  callback = function(_, bufnr)
    nnoremap '<leader>gnd'(lsp.type_definition)(opts(bufnr)) 'Show type definition of symbol under cursor'
  end,
}

M.symbol = {
  name = 'workspace/symbol',
  callback = function(_, bufnr)
    vim.notify('workspace', vim.log.levels.INFO)
    nnoremap 'gS'(function() lsp.workspace_symbol(vim.fn.input { prompt = '> Search: ' }) end)(
      opts(bufnr)
    ) 'View Workspace symbols'
  end,
}

return M
