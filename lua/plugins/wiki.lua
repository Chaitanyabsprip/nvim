local u = require("utils")

--[[ nmap <Leader>vv <Plug>VimwikiIndex
nmap <Leader>vt <Plug>VimwikiTabIndex
nmap <Leader>vs <Plug>VimwikiUISelect
nmap <Leader>vi <Plug>VimwikiDiaryIndex
nmap <Leader>vh <Plug>Vimwiki2HTML
nmap <Leader>vhb <Plug>Vimwiki2HTMLBrowse
nmap <Leader>v<Leader>v <Plug>VimwikiMakeDiaryNote
nmap <Leader>v<Leader>t <Plug>VimwikiTabMakeDiaryNote
nmap <Leader>v<Leader>y <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>v<Leader>m <Plug>VimwikiMakeTomorrowDiaryNote
nmap <Leader>v<Leader>i <Plug>VimwikiDiaryGenerateLinks ]]

u.kmap('n', '<leader>vv', '<Plug>VimwikiIndex', {noremap = true})
u.kmap('n', '<leader>vt', '<Plug>VimwikiTabIndex', {noremap = true})
u.kmap('n', '<leader>vs', '<Plug>VimwikiUISelect', {noremap = true})
u.kmap('n', '<leader>vi', '<Plug>VimwikiDiaryIndex', {noremap = true})
u.kmap('n', '<leader>vh', '<Plug>Vimwiki2HTML', {noremap = true})
u.kmap('n', '<leader>vhb', '<Plug>Vimwiki2HTMLBrowse', {noremap = true})
u.kmap('n', '<leader>v<leader>v', '<Plug>VimwikiMakeDiaryNote', {noremap = true})
u.kmap('n', '<leader>v<leader>t', '<Plug>VimwikiTabMakeDiaryNote',
       {noremap = true})
u.kmap('n', '<leader>v<leader>y', '<Plug>VimwikiMakeYesterdayDiaryNote',
       {noremap = true})
u.kmap('n', '<leader>v<leader>m', '<Plug>VimwikiMakeTomorrowDiaryNote',
       {noremap = true})
u.kmap('n', '<leader>v<leader>i', '<Plug>VimwikiDiaryGenerateLinks',
       {noremap = true})
