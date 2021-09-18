vim.cmd [[ hi! Indentline1 guifg=#eb6f92 ]]
vim.cmd [[ hi! Indentline2 guifg=#f6c177 ]]
vim.cmd [[ hi! Indentline3 guifg=#ebbcba ]]
vim.cmd [[ hi! Indentline4 guifg=#31748f ]]
vim.cmd [[ hi! Indentline5 guifg=#9ccfd8 ]]
vim.cmd [[ hi! Indentline6 guifg=#c4a7e7 ]]

-- vim.g.indent_blankline_enabled = true
-- vim.g.indentLine_showFirstIndentLevel = 1
-- vim.g.indentLine_setColors = 1
-- vim.cmd "let g:indent_blankline_char_highlight_list = [\" Indentline1 \", \" Indentline2 \", \" Indentline3 \", \" Indentline4 \"]"
-- vim.cmd "let g:indent_blankline_filetype_exclude = ['startify']"

require("indent_blankline").setup {
  buftype_exclude = {"terminal"},
  filetype_exclude = {"startify", "packer"},
  char_highlight_list = {
    "Indentline1", "Indentline2", "Indentline3", "Indentline4", "Indentline5",
    "Indentline6"
  },
  enabled = true,
  indent_level = 6,
  setColors = true,
  show_current_context = true,
  show_first_indent_level = false,
  use_treesitter = true
}
