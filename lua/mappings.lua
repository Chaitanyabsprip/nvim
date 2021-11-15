local u = require("utils")
local nt = {noremap = true}
local ntst = {noremap = true, silent = true}

-- j/k will move virtual lines (lines that wrap)
--[[ u.keymap('n', 'j', '(v:count == 0 ? \'gj\' : \'j\')',
                        {expr = true, noremap = true})
u.keymap('n', 'k', '(v:count == 0 ? \'gk\' : \'k\')',
                        {expr = true, noremap = true}) ]]
-- easy command mode
u.kmap('n', ';', ':', nt)
u.kmap('n', ':', ';', nt)

-- Go to start or end of line easier
u.kmap('n', 'H', '^', nt)
u.kmap('x', 'H', '^', nt)
u.kmap('n', 'L', 'g_', nt)
u.kmap('x', 'L', 'g_', nt)

-- I hate escape more than anything else
u.kmap('i', 'jk', '<Esc>', nt)
u.kmap('i', 'kj', '<Esc>', nt)

-- terminal binds
-- u.kmap('t', '<Esc>', '<C-\\><C-n>', ntst)
-- u.kmap('t', '<A-[>', '<C-\\><C-n>', nt)
-- u.kmap('t', 'jk', '<C-\\><C-n>', nt)
-- u.kmap('t', 'kj', '<C-\\><C-n>', nt)

-- move lines up and down
u.kmap('n', '<M-j>', ':m .+1<CR>==', ntst)
u.kmap('n', '<M-k>', ':m .-2<CR>==', ntst)
u.kmap('i', '<M-j>', '<Esc>:m .+1<CR>==gi', ntst)
u.kmap('i', '<M-k>', '<Esc>:m .-2<CR>==gi', ntst)
u.kmap('v', '<M-j>', ":m \'>+1<CR>gv=gv", ntst)
u.kmap('v', '<M-k>', ":m \'<-2<CR>gv=gv", ntst)

-- better yank
u.kmap('n', '<leader>y', 'gg"+yG', nt)
u.kmap('n', 'Y', 'y$', nt)

-- better undo breakpoints
u.kmap('i', ',', ',<C-g>U', nt)
u.kmap('i', '.', '.<C-g>U', nt)
u.kmap('i', '!', '!<C-g>U', nt)
u.kmap('i', '?', '?<C-g>U', nt)

-- sort
u.kmap('v', 'gs', ":sort<CR>", nt)

-- better search/block jumping and line joining
u.kmap('n', 'n', 'nzzzv', nt)
u.kmap('n', 'N', 'Nzzzv', nt)
u.kmap('n', 'J', 'mzJ`z', nt)
u.kmap('n', '}', '}zzzv', nt)
u.kmap('n', '{', '{zzzv', nt)

-- add blank lines on top or bottom of the current line
u.kmap('n', '<C-j>', 'o<Esc>k', nt)
u.kmap('n', '<C-k>', 'O<Esc>j', nt)

-- better tabbing
u.kmap('v', '<', '<gv', nt)
u.kmap('v', '>', '>gv', nt)

-- Insert a space after current character
-- u.kmap('n', '<Space><Space>', 'a<Space><Esc>h', ntst)

-- Leader bindings
u.kmap('n', '<Space>', '<NOP>', ntst)
vim.g.mapleader = ' '

-- save file
u.kmap('n', '<leader>w', ':w!<CR>', ntst)

------------------------------------------------------------------------
-- Windows keymap
------------------------------------------------------------------------
-- move between open windows
u.kmap('n', '<leader>h', ':wincmd h<CR>', ntst)
u.kmap('n', '<leader>j', ':wincmd j<CR>', ntst)
u.kmap('n', '<leader>k', ':wincmd k<CR>', ntst)
u.kmap('n', '<leader>l', ':wincmd l<CR>', ntst)

-- move windows accordingly
u.kmap('n', '<leader>H', ':wincmd H<CR>', ntst)
u.kmap('n', '<leader>J', ':wincmd J<CR>', ntst)
u.kmap('n', '<leader>K', ':wincmd K<CR>', ntst)
u.kmap('n', '<leader>L', ':wincmd L<CR>', ntst)

-- close current window
u.kmap('n', '<leader>q', ':q<CR>', ntst)
u.kmap('n', '<leader>x', ':bd<CR>', ntst)

-- window resize
u.kmap('n', ')', ':vertical resize +5<CR>', ntst)
u.kmap('n', '(', ':vertical resize -5<CR>', ntst)
u.kmap('n', '+', ':res +1<CR>', ntst)
u.kmap('n', '-', ':res -1<CR>', ntst)

-- TAB in general mode will move between tabs
u.kmap('n', '<TAB>', 'gt', nt)
u.kmap('n', '<S-TAB>', 'gT', nt)
u.kmap('n', 'gF', ':tabe <cfile><CR>', nt)

-- refresh buffer, reads the current file from disk. Helps refresh Lsp and other buffer plugins
u.kmap('n', '<C-e>', ':e!<CR>', {noremap = true, silent = true})

vim.cmd [[
nnoremap <leader>y gg"+yG
nnoremap <leader>Y gvy
nnoremap <leader>v ggVG
]]

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>ZenMode<CR>', ntst)
