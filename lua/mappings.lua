local nmap = function(key, cmd, silent)
  require('utils').map('n', key, cmd, { silent = silent })
end
local nnoremap = require('utils').nnoremap
local inoremap = require('utils').inoremap
local tnoremap = require('utils').tnoremap
local vnoremap = require('utils').vnoremap
local xnoremap = require('utils').xnoremap

-- j/k will move virtual lines (lines that wrap)
--[[ u.kmap('n', 'j', '(v:count == 0 ? \'gj\' : \'j\')',
                        {expr = true, noremap = true})
u.kmap('n', 'k', '(v:count == 0 ? \'gk\' : \'k\')',
                        {expr = true, noremap = true}) ]]
-- easy command mode
nnoremap(';', ':')
nnoremap(':', ';')
vnoremap(';', ':')
vnoremap(':', ';')

-- Go to start or end of line easier
nnoremap('H', '^')
xnoremap('H', '^')
nnoremap('L', 'g_')
xnoremap('L', 'g_')

-- I hate escape more than anything else
inoremap('jk', '<Esc>')
inoremap('kj', '<Esc>')

-- terminal binds
tnoremap('<Esc>', '<C-\\><C-n>')
tnoremap('<A-[>', '<C-\\><C-n>')
tnoremap('jk', '<C-\\><C-n>')
tnoremap('kj', '<C-\\><C-n>')

-- move lines up and down
nnoremap('<M-j>', ':m .+1<CR>==', true)
nnoremap('<M-k>', ':m .-2<CR>==', true)
inoremap('<M-j>', '<Esc>:m .+1<CR>==gi')
inoremap('<M-k>', '<Esc>:m .-2<CR>==gi')
vnoremap('<M-j>', ":m '>+1<CR>gv=gv")
vnoremap('<M-k>', ":m '<-2<CR>gv=gv")

-- better yank
nnoremap('<leader>y', 'gg"+yG')
vnoremap('p', '"_dP')

-- better undo breakpoints
inoremap(',', ',<C-g>U')
inoremap('.', '.<C-g>U')
inoremap('!', '!<C-g>U')
inoremap('?', '?<C-g>U')

-- sort
vnoremap('gs', ':sort<CR>')

-- better search/block jumping and line joining
nnoremap('n', 'nzzzv')
nnoremap('N', 'Nzzzv')
nnoremap('J', 'mzJ`z')
nnoremap('}', '}zzzv')
nnoremap('{', '{zzzv')

-- add blank lines on top or bottom of the current line
nnoremap('<a-s-j>', 'o<Esc>k')
nnoremap('<a-s-k>', 'O<Esc>j')

-- better indent
vnoremap('<', '<gv')
vnoremap('>', '>gv')

-- Leader bindings
nnoremap('<Space>', '<NOP>', true)
vim.g.mapleader = ' '

-- save file
nnoremap('<leader>w', ':up<CR>')

------------------------------------------------------------------------
-- Windows keymap
------------------------------------------------------------------------
-- move between open windows
nnoremap('<c-h>', ':wincmd h<CR>', true)
nnoremap('<c-j>', ':wincmd j<CR>', true)
nnoremap('<c-k>', ':wincmd k<CR>', true)
nnoremap('<c-l>', ':wincmd l<CR>', true)

-- move windows accordingly
nnoremap('<leader>H', ':wincmd H<CR>', true)
nnoremap('<leader>J', ':wincmd J<CR>', true)
nnoremap('<leader>K', ':wincmd K<CR>', true)
nnoremap('<leader>L', ':wincmd L<CR>', true)

-- create new windows
nnoremap('<leader>h', ':vne<CR><c-w>r', true)
nnoremap('<leader>l', ':vne<CR>', true)
nnoremap('<leader>j', ':bel new<CR>', true)
nnoremap('<leader>k', ':abo new<CR>', true)

-- close current window
nnoremap('<leader>q', ':qa<CR>', true)
nnoremap('<leader>x', ':bd<CR>', true)
nnoremap('<leader>Q', ':bufdo bdelete<CR>', true)

-- window resize
nnoremap(')', ':vertical resize +5<CR>', true)
nnoremap('(', ':vertical resize -5<CR>', true)
nnoremap('+', ':res +1<CR>', true)
nnoremap('-', ':res -1<CR>', true)

-- TAB in normal mode will move to text buffer
nnoremap('<TAB>', ':bnext<CR>', true)
nnoremap('<S-TAB>', ':bprevious<CR>', true)
nnoremap('gF', ':tabe <cfile><CR>')

-- refresh buffer, reads the current file from disk. Helps refresh Lsp and other buffer plugins
nnoremap('<C-e>', ':e!<CR>', true)

-- spell
nnoremap('<F11>', ':set spell!<cr>', true)
inoremap('<F11>', '<C-O>:set spell!<cr>')

-- surround
nmap('<leader>`', 'viws`', true)
nmap('<leader>-', 'viwc__<Esc>hp', true)

vim.cmd [[
nnoremap <leader>y gg"+yG
nnoremap <leader>Y gvy
nnoremap <leader>v ggVG
]]

nnoremap('<leader>z', '<cmd>ZenMode<CR>', true)
