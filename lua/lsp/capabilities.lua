local M = {}
local mappings = require 'mappings.hashish'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap
local augroup = function(group) vim.api.nvim_create_augroup(group, { clear = true }) end
local autocmd = function(event, opts)
  if not opts.disable then vim.api.nvim_create_autocmd(event, opts) end
end
local opts = { bufnr = 0, silent = true }

M['textDocument/codeAction'] = function(_)
  nnoremap '<leader>a'(require('lsp-fastaction').code_action)(opts) 'Show code actions for the current cursor position'
  vnoremap '<leader>a' '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>'(opts) 'Show code actions for the current selection range'
end

M['textDocument/codeLens'] = function(_)
  autocmd({ 'BufEnter, InsertLeave, BufWritePost', 'CursorHold' }, {
    group = augroup 'lsp_codelens_refresh',
    buffer = 0,
    callback = function() vim.lsp.codelens.refresh() end,
  })
end

M['textDocument/declaration'] = function(_)
  nnoremap 'gD'(vim.lsp.buf.declaration())(opts) 'Go to declaration of symbol under cursor'
end

M['textDocument/formatting'] = function(_)
  autocmd({ 'BufWritePre' }, {
    group = augroup 'auto_format',
    buffer = 0,
    callback = function() vim.lsp.buf.format() end,
  })
end

M['textDocument/documentHighlight'] = function(_)
  vim.schedule(
    function()
      vim.cmd [[
        hi LspReferenceRead cterm=underline ctermbg=none gui=underline guibg=none
        hi LspReferenceText cterm=underline ctermbg=none gui=underline guibg=none
        hi LspReferenceWrite cterm=underline ctermbg=none gui=underline guibg=none
        hi link LspReferenceRead Folded
        hi link LspReferenceText Folded
        hi link LspReferenceWrite Folded
      ]]
    end
  )
end

M['textDocument/rangeFormatting'] = function(_) end

M['textDocument/documentSymbols'] = function(_) end

M['textDocument/references'] = function(_)
  local theme = require('telescope.themes').get_cursor {
    layout_strategy = 'cursor',
    layout_config = { width = 100, height = 10 },
    previewer = false,
  }
  local lsp_references = function() require('telescope.builtin').lsp_references(theme) end
  nnoremap 'gR'(lsp_references)(opts) 'Find references of symbol under cursor'
end

M['textDocument/definition'] = function(_)
  nnoremap 'gd'(require('telescope.builtin').lsp_definitions)(opts) 'Go to definition of symbol under cursor'
end

M['textDocument/hover'] =
  function(_) nnoremap 'K'(vim.lsp.buf.hover)(opts) 'Show hover info of symbol under cursor' end

M['textDocument/implementation'] = function(_)
  nnoremap 'gi'(require('telescope.builtin').lsp_implementations)(opts) 'Show implementations of symbol under cursor'
end

M['textDocument/rename'] = function(_)
  nnoremap 'gr'(function() vim.ui.input({ prompt = 'Rename: ' }, vim.lsp.buf.rename) end)(opts) 'Rename symbol under cursor'
end

M['textDocument/signatureHelp'] = function(_)
  nnoremap 'sh'(vim.lsp.buf.signature_help)(opts) 'Show signature help of symbol under cursor'
end

M['textDocument/typeDefinition'] = function(_)
  nnoremap '<leader>gnd'(vim.lsp.buf.type_definition)(opts) 'Show type definition of symbol under cursor'
end

M['workspace/symbol'] = function(_) end

return M
