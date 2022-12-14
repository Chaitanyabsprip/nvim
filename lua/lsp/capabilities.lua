local M = {}
local mappings = require 'mappings.hashish'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap

M['textDocument/codeAction'] = function(_)
  nnoremap '<leader>a' '<cmd>lua require("lsp-fastaction").code_action()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show code actions for the current cursor position'
  vnoremap '<leader>a' '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show code actions for the current selection range'
end

M['textDocument/codeLens'] = function(_)
  vim.cmd [[
        augroup lsp_codelens_refresh
            autocmd! * <buffer>
            autocmd BufEnter,InsertLeave,BufWritePost <buffer> lua vim.lsp.codelens.refresh()
            autocmd CursorHold <buffer> lua vim.lsp.codelens.refresh()
        augroup END
    ]]
end

M['textDocument/declaration'] = function(_)
  nnoremap 'gD' '<cmd>lua vim.lsp.buf.declaration()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Go to declaration of symbol under cursor'
end

M['textDocument/formatting'] = function(_)
  vim.cmd [[
      augroup auto_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format(nil, 1000)
      augroup end
    ]]
end

M['textDocument/documentHighlight'] = function(_)
  vim.schedule(function()
    vim.cmd [[
        hi LspReferenceRead cterm=underline ctermbg=none gui=underline guibg=none
        hi LspReferenceText cterm=underline ctermbg=none gui=underline guibg=none
        hi LspReferenceWrite cterm=underline ctermbg=none gui=underline guibg=none
        hi link LspReferenceRead Folded
        hi link LspReferenceText Folded
        hi link LspReferenceWrite Folded
      ]]
  end)
end

M['textDocument/rangeFormatting'] = function(_) end

M['textDocument/documentSymbols'] = function(_) end

M['textDocument/references'] = function(_)
  nnoremap '<c-g>r' "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({layout_strategy='cursor', layout_config={width=100, height=10}, previewer = false}))<cr>" {
    bufnr = 0,
    silent = true,
  } 'Find references of symbol under cursor'
end

M['textDocument/definition'] = function(_)
  nnoremap '<c-g>d' '<cmd>Telescope lsp_definitions<cr>' {
    bufnr = 0,
    silent = true,
  } 'Go to definition of symbol under cursor'
end

M['textDocument/hover'] = function(_)
  nnoremap 'K' '<cmd>lua vim.lsp.buf.hover()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show hover info of symbol under cursor'
end

M['textDocument/implementation'] = function(_)
  nnoremap '<c-g>i' '<cmd>Telescope lsp_implementations<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show implementations of symbol under cursor'
end

M['textDocument/rename'] = function(_)
  nnoremap 'gr'(function()
    vim.ui.input({ prompt = 'Rename: ' }, vim.lsp.buf.rename)
  end) { bufnr = 0, silent = true } 'Rename symbol under cursor'
end

M['textDocument/signatureHelp'] = function(_)
  nnoremap 'gh' '<cmd>lua vim.lsp.buf.signature_help()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show signature help of symbol under cursor'
end

M['textDocument/typeDefinition'] = function(_)
  nnoremap '<leader>gnd' '<cmd>lua vim.lsp.buf.type_definition()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show type definition of symbol under cursor'
end

M['workspace/symbol'] = function(_) end

return M
