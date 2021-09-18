vim.api.nvim_exec([[
let g:startify_bookmarks = [{ 'i': '~/.config/nvim/init.lua' }]
let g:startify_lists = [{'type':'files','header': ['Files']},{'type':'dir','header':['Current Directory'.getcwd()]}, { 'type':'bookmarks', 'header':['Bookmarks']}, {'type':'sessions', 'header':['Sessions']}]
]], false)
