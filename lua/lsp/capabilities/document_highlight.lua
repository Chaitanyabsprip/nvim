return function(_)
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
