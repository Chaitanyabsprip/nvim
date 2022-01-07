return function(_)
  vim.cmd [[
      augroup auto_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1500)
      augroup end
    ]]
end
