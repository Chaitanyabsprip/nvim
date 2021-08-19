vim.api.nvim_exec([[
let g:startify_bookmarks = [{ 'c': '~/.config/qtile/config.py' }, { 'i': '~/.config/nvim/init.lua' }]
let g:startify_lists = [{ 'type':'bookmarks', 'header':['Bookmarks']},{'type':'files','header': ['Files']},{'type':'dir','header':['Current Directory'.getcwd()]}, {'type':'sessions', 'header':['Sessions']}]
]], false)
