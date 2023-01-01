local M = {}
local mappings = require 'mappings.hashish'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap
local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
local autocmd = function(event, opts)
  if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
end
local opts = { bufnr = 0, silent = true }
local lsp = vim.lsp.buf

M.code_action = {
  name = 'textDocument/codeAction',
  callback = function()
    nnoremap '<leader>a'(require('lsp-fastaction').code_action)(opts) 'Show code actions for the current cursor position'
    vnoremap '<leader>a' '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>'(opts) 'Show code actions for the current selection range'
  end,
}

M.code_lens = {
  name = 'textDocument/codeLens',
  callback = function()
    autocmd({ 'BufEnter, InsertLeave, BufWritePost', 'CursorHold' }, {
      group = augroup 'lsp_codelens_refresh',
      buffer = 0,
      callback = function() vim.lsp.codelens.refresh() end,
    })
  end,
}

M.declaration = {
  name = 'textDocument/declaration',
  callback = function()
    nnoremap 'gD'(lsp.declaration)(opts) 'Go to declaration of symbol under cursor'
  end,
}

M.formatting = {
  name = 'textDocument/formatting',
  callback = function()
    autocmd(
      'BufWritePre',
      { group = augroup 'auto_format', buffer = 0, callback = function() lsp.format() end }
    )
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
  name = 'textDocument/documentSymbols',
  callback = function() end,
}

M.references = {
  name = 'textDocument/references',
  callback = function()
    nnoremap 'gR'(lsp.references)(opts) 'Find references of symbol under cursor'
  end,
}

M.definition = {
  name = 'textDocument/definition',
  callback = function()
    nnoremap 'gd'(lsp.definition)(opts) 'Go to definition of symbol under cursor'
  end,
}

M.hover = {
  name = 'textDocument/hover',
  callback = function() nnoremap 'K'(lsp.hover)(opts) 'Show hover info of symbol under cursor' end,
}

M.implementation = {
  name = 'textDocument/implementation',
  callback = function()
    nnoremap 'gi'(lsp.implementation)(opts) 'Show implementations of symbol under cursor'
  end,
}

M.rename = {
  name = 'textDocument/rename',
  callback = function()
    nnoremap 'gr'(function() vim.ui.input({ prompt = 'Rename: ' }, lsp.rename) end)(opts) 'Rename symbol under cursor'
  end,
}

M.signature_help = {
  name = 'textDocument/signatureHelp',
  callback = function()
  end,
}

M.type_definition = {
  name = 'textDocument/typeDefinition',
  callback = function()
    nnoremap '<leader>gnd'(lsp.type_definition)(opts) 'Show type definition of symbol under cursor'
  end,
}

M.symbol = { name = 'workspace/symbol', callback = function() end }

return M
