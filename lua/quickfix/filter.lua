local filter = {}
function filter.setlist(pat, range, reject, strategy)
  local operator = reject == 0 and '=~' or '!~'
  local max_height = (vim.g.qf_max_height or 10) < 1 and 10 or vim.g.qf_max_height or 10
  if vim.b.qf_isLoc then
    if strategy == 0 then
      vim.fn.setloclist(0, vim.tbl_filter(vim.fn.getloclist(0), ))
    end
    if strategy == 1 then
    end
    if strategy == 2 then
    end
    if strategy == 3 then
    end
  end
end
-- function! s:SetList(pat, range, reject, strategy)
--     " decide what regexp operator to use
--     let operator   = a:reject == 0 ? '=~' : '!~'
--     " get user-defined maximum height
--     let max_height = get(g:, 'qf_max_height', 10) < 1 ? 10 : get(g:, 'qf_max_height', 10)
--
--     if exists("b:qf_isLoc")
--         if b:qf_isLoc == 1
--             " bufname && text
--             if a:strategy == 0
--                 call setloclist(0, filter(getloclist(0), "(bufname(v:val['bufnr']) . v:val['text'] " . operator . " a:pat)"), "r")
--             endif
--
--             " only bufname
--             if a:strategy == 1
--                 call setloclist(0, filter(getloclist(0), "bufname(v:val['bufnr']) " . operator . " a:pat"), "r")
--             endif
--
--             " only text
--             if a:strategy == 2
--                 call setloclist(0, filter(getloclist(0), "v:val['text'] " . operator . " a:pat"), "r")
--             endif
--
--             " range
--             if a:strategy == 3
--                 let current_list = getloclist(0)
--                 if a:reject
--                     " remove range from list
--                     call remove(current_list, a:range[0], a:range[1])
--                     call setloclist(0, current_list, "r")
--                 else
--                     " take range from list
--                     call setloclist(0, remove(current_list, a:range[0], a:range[1]), "r")
--                 endif
--             endif
--
--             execute get(g:, "qf_auto_resize", 1) ? 'lclose|' . min([ max_height, len(getloclist(0)) ]) . 'lwindow' : 'lclose|lwindow'
--         else
--             " bufname && text
--             if a:strategy == 0
--                 call setqflist(filter(getqflist(), "(bufname(v:val['bufnr']) . v:val['text'] " . operator . " a:pat)"), "r")
--             endif
--
--             " only bufname
--             if a:strategy == 1
--                 call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . operator . " a:pat"), "r")
--             endif
--
--             " only text
--             if a:strategy == 2
--                 call setqflist(filter(getqflist(), "v:val['text'] " . operator . " a:pat"), "r")
--             endif
--
--             " range
--             if a:strategy == 3
--                 let current_list = getqflist()
--                 if a:reject
--                     " remove range from list
--                     call remove(current_list, a:range[0], a:range[1])
--                     call setqflist(current_list, "r")
--                 else
--                     " take range from list
--                     call setqflist(remove(current_list, a:range[0], a:range[1]), "r")
--                 endif
--             endif
--
--             execute get(g:, "qf_auto_resize", 1) ? 'cclose|' . min([ max_height, len(getqflist()) ]) . 'cwindow' : 'cclose|cwindow'
--         endif
--     endif
-- endfunction
return filter
