vim.cmd "hi! indentline1 cterm=NONE ctermfg=209 ctermbg=209 gui=NONE guifg=#f09483 guibg = #f09483"
vim.cmd "hi! indentline2 cterm=NONE ctermfg=44 ctermbg=44 gui=NONE guifg=#21bfc2 guibg = #21bfc2"
vim.cmd "hi! indentline3 cterm=NONE ctermfg=203 ctermbg=203 gui=NONE guifg=#e95678 guibg = #e95678"
vim.cmd "hi! indentline4 cterm=NONE ctermfg=171 ctermbg=171 gui=NONE guifg=#b877db guibg = #b877db"

vim.g.indent_blankline_enabled = true
vim.g.indentLine_showFirstIndentLevel = 1
vim.g.indentLine_setColors = 1
-- vim.cmd "let g:indent_blankline_char_highlight_list = [\" indentline1 \", \" indentline2 \", \" indentline3 \", \" indentline4 \"]"
vim.cmd "let g:indent_blankline_filetype_exclude = ['startify']"
