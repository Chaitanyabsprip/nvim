local u = require("utils")
local nt = {noremap = true}
local ntst = {noremap = true, silent = true}

-- j/k will move virtual lines (lines that wrap)
--[[ u.keymap('n', 'j', '(v:count == 0 ? \'gj\' : \'j\')',
                        {expr = true, noremap = true})
u.keymap('n', 'k', '(v:count == 0 ? \'gk\' : \'k\')',
                        {expr = true, noremap = true}) ]]

-- Go to start or end of line easier
u.keymap('n', 'H', '^', nt)
u.keymap('x', 'H', '^', nt)
u.keymap('n', 'L', 'g_', nt)
u.keymap('x', 'L', 'g_', nt)

-- I hate escape more than anything else
u.keymap('i', 'jk', '<Esc>', nt)
u.keymap('i', 'kj', '<Esc>', nt)

-- terminal binds
u.keymap('t', '<Esc>', '<C-\\><C-n>', ntst)
u.keymap('t', '<A-[>', '<C-\\><C-n>', nt)
u.keymap('t', 'jk', '<C-\\><C-n>', nt)
u.keymap('t', 'kj', '<C-\\><C-n>', nt)

-- move lines up and down
u.keymap('n', '<M-j>', ':m .+1<CR>==', ntst)
u.keymap('n', '<M-k>', ':m .-2<CR>==', ntst)
u.keymap('i', '<M-j>', '<Esc>:m .+1<CR>==gi', ntst)
u.keymap('i', '<M-k>', '<Esc>:m .-2<CR>==gi', ntst)
u.keymap('v', '<M-j>', ":m \'>+1<CR>gv=gv", ntst)
u.keymap('v', '<M-k>', ":m \'<-2<CR>gv=gv", ntst)

-- better yank
u.keymap('n', '<leader>y', 'gg"+yG', nt)
u.keymap('n', 'Y', 'y$', nt)

-- better undo breakpoints
u.keymap('i', ',', ',<C-g>U', nt)
u.keymap('i', '.', '.<C-g>U', nt)
u.keymap('i', '!', '!<C-g>U', nt)
u.keymap('i', '?', '?<C-g>U', nt)

-- sort
u.keymap('v', 'gs', ":sort<CR>", nt)

-- better search jumping and line joining
u.keymap('n', 'n', 'nzzzv', nt)
u.keymap('n', 'N', 'Nzzzv', nt)
u.keymap('n', 'J', 'mzJ`z', nt)

-- add blank lines on top or bottom of the current line
u.keymap('n', '<C-j>', 'o<Esc>k', nt)
u.keymap('n', '<C-k>', 'O<Esc>j', nt)

-- better tabbing
u.keymap('v', '<', '<gv', nt)
u.keymap('v', '>', '>gv', nt)

-- Insert a space after current character
u.keymap('n', '<Space><Space>', 'a<Space><Esc>h', ntst)

-- Leader bindings
u.keymap('n', '<Space>', '<NOP>', ntst)
vim.g.mapleader = ' '

-- save file
u.keymap('n', '<leader>w', ':w!<CR>', ntst)

------------------------------------------------------------------------
-- Windows keymap
------------------------------------------------------------------------
-- move between open windows
u.keymap('n', '<leader>h', ':wincmd h<CR>', ntst)
u.keymap('n', '<leader>j', ':wincmd j<CR>', ntst)
u.keymap('n', '<leader>k', ':wincmd k<CR>', ntst)
u.keymap('n', '<leader>l', ':wincmd l<CR>', ntst)

-- move windows accordingly
u.keymap('n', '<leader>H', ':wincmd H<CR>', ntst)
u.keymap('n', '<leader>J', ':wincmd J<CR>', ntst)
u.keymap('n', '<leader>K', ':wincmd K<CR>', ntst)
u.keymap('n', '<leader>L', ':wincmd L<CR>', ntst)

-- close current window
u.keymap('n', '<leader>q', ':q<CR>', ntst)

-- window resize
u.keymap('n', ')', ':vertical resize +5<CR>', ntst)
u.keymap('n', '(', ':vertical resize -5<CR>', ntst)
u.keymap('n', '+', ':res +1<CR>', ntst)
u.keymap('n', '-', ':res -1<CR>', ntst)

-- TAB in general mode will move between tabs
u.keymap('n', '<TAB>', 'gt', nt)
u.keymap('n', '<S-TAB>', 'gT', nt)
u.keymap('n', 'gF', ':tabe <cfile><CR>', nt)

-- move through buffers
u.keymap('n', '<leader>[', ':bp!<CR>', {})
u.keymap('n', '<leader>]', ':bn!<CR>', {})
u.keymap('n', '<leader>x', ':bd<CR>', {})

-- refresh buffer, reads the current file from disk. Helps refresh Lsp and other buffer plugins
u.keymap('n', '<C-e>', ':e!<CR>', {noremap = true, silent = true})

vim.cmd [[
nnoremap <leader>y gg"+yG
nnoremap <leader>Y gvy
nnoremap <leader>v ggVG
]]

vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>ZenMode<CR>', ntst)
