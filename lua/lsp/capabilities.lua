local M = {}
local mappings = require 'mappings'
local nnoremap = mappings.nnoremap
local vnoremap = mappings.vnoremap

M.code_action = function(_)
  nnoremap '<leader>a' '<cmd>lua require("lsp-fastaction").code_action()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show code actions for the current cursor position'
  vnoremap '<leader>a' '<esc><cmd>lua require("lsp-fastaction").range_code_action()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show code actions for the current selection range'
end

M.code_lens = function(_)
  vim.cmd [[
        augroup lsp_codelens_refresh
            autocmd! * <buffer>
            autocmd BufEnter,InsertLeave,BufWritePost <buffer> lua vim.lsp.codelens.refresh()
            autocmd CursorHold <buffer> lua vim.lsp.codelens.refresh()
        augroup END
    ]]
end

M.declaration = function(_)
  nnoremap 'gD' '<cmd>lua vim.lsp.buf.declaration()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Go to declaration of symbol under cursor'
end

M.document_formatting = function(_)
  vim.cmd [[
      augroup auto_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1500)
      augroup end
    ]]
end

M.document_highlight = function(_)
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
  vim.cmd [[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]]
end

M.document_range_formatting = function(_) end

M.document_symbol = function(_) end

M.find_references = function(_)
  -- nnoremap 'gR' '<cmd>Trouble lsp_references<cr>' {bufnr = 0, silent = true}
  -- 'Find references of symbol under cursor'
  nnoremap 'gR' "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({layout_strategy='cursor', layout_config={width=100, height=10}, previewer = false}))<cr>" {
    bufnr = 0,
    silent = true,
  } 'Find references of symbol under cursor'
end

M.goto_definition = function(_)
  nnoremap 'gd' '<cmd>Trouble lsp_definitions<cr>' {
    bufnr = 0,
    silent = true,
  } 'Go to definition of symbol under cursor'
end

M.hover = function(_)
  nnoremap 'K' '<cmd>lua vim.lsp.buf.hover()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show hover info of symbol under cursor'
end

M.implementation = function(_)
  nnoremap 'gI' '<cmd>Trouble lsp_implementations<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show implementations of symbol under cursor'
end

M.rename = function(_)
  nnoremap 'gr' "<cmd>lua require('renamer').rename()<cr>" {
    bufnr = 0,
    silent = true,
  } 'Rename symbol under cursor'
end

M.signature_help = function(_)
  nnoremap 'gh' '<cmd>lua vim.lsp.buf.signature_help()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show signature help of symbol under cursor'
end

M.type_definition = function(_)
  nnoremap '<leader>gnd' '<cmd>lua vim.lsp.buf.type_definition()<cr>' {
    bufnr = 0,
    silent = true,
  } 'Show type definition of symbol under cursor'
end

M.workspace_symbol = function(_) end

return M
