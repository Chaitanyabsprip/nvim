local keymaps = {}

keymaps.setup = function()
  local hashish = require 'hashish'
  local map = hashish.map
  local nnoremap = hashish.nnoremap
  local vnoremap = hashish.vnoremap
  local tnoremap = hashish.tnoremap
  local inoremap = hashish.inoremap
  local xnoremap = hashish.xnoremap

  -- Leader bindings
  nnoremap '<Space>' '<NOP>' 'Leader key'
  vim.g.mapleader = ' '

  require('utils').cowboy { 'NvimTree', 'qf', 'help', 'noice' }
  nnoremap '<leader>w' '<cmd>up<cr>' 'Save file (only if modified)'
  inoremap 'jk' '<esc>' 'Escape insert mode'
  inoremap 'kj' '<esc>' 'Escape insert mode'
  inoremap '<c-c>' '<esc>' 'Escape insert mode'
  tnoremap '<esc>' '<C-\\><C-n>' 'Escape insert mode in terminal'
  tnoremap 'jk' '<C-\\><C-n>' 'Escape insert mode in terminal'
  tnoremap 'kj' '<C-\\><C-n>' 'Escape insert mode in terminal'
  nnoremap '<leader>q' '<cmd>q<cr>' 'Close window (:q)'
  nnoremap '<leader>Q' '<cmd>qa<cr>' 'Quit all (:qa)'
  nnoremap '<leader>e' '<cmd>Explorer<cr>' 'Toggle file explorer'
  nnoremap '_' '^' 'Jump to the start of the line'
  xnoremap '_' '^' 'Jump to the start of the line'
  nnoremap '&' 'g_' 'Jump to the end of the line'
  xnoremap '&' 'g_' 'Jump to the end of the line'
  nnoremap 'gh' '<c-w>h' 'Move to the window on the left'
  nnoremap 'gl' '<c-w>l' 'Move to the window on the right'
  nnoremap 'gj' '<c-w>j' 'Move to the window on the below'
  nnoremap 'gk' '<c-w>k' 'Move to the window on the above'
  vnoremap 'J' ":m '>+1<cr>gv=gv" { silent = true } 'Move selected lines down'
  vnoremap 'K' ":m '<-2<cr>gv=gv" { silent = true } 'Move selected lines up'
  nnoremap 'X' '<cmd>bd<cr>' 'Close current buffer'
  nnoremap ')' '<cmd>vertical resize +5<cr>' 'Increase current window height'
  nnoremap '(' '<cmd>vertical resize -5<cr>' 'Decrease current window height'
  nnoremap '+' '<cmd>res +1<cr>' 'Increase current window width'
  nnoremap '-' '<cmd>res -1<cr>' 'Decrease current window width'
  vnoremap '<' '<gv' 'Maintain visual selection while decreasing indent'
  vnoremap '>' '>gv' 'Maintain visual selection while increasing indent'
  vnoremap '=' '=gv' 'Maintain visual selection while auto fixing indent'
  nnoremap '<leader>y' '<cmd>%y+<cr>' 'Yank whole buffer to system clipboard'
  nnoremap '<leader>v' 'ggVG' 'Select whole buffer'
  vnoremap 'p' '"_dP' 'Paste inplace without yanking selected text'
  nnoremap '<TAB>' '<cmd>bnext<cr>' 'Focus next buffer'
  nnoremap '<S-TAB>' '<cmd>:bprevious<cr>' 'Focus previous buffer'
  nnoremap 'n' 'nzzzv' 'Jump to next match and center line'
  nnoremap 'N' 'Nzzzv' 'Jump to previous match and center line'
  nnoremap 'J' 'mzJ`z' 'Join lines without moving cursor'
  nnoremap '}' '}zzzv' 'Like text object motion } but centers line'
  nnoremap '{' '{zzzv' 'Like text object motion { but centers line'
  nnoremap '<leader>r' ':%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<Left><Left><Left>' 'Search and replace, in current buffer, word under cursor'
  vnoremap '<leader>r' '"hy:%s/<C-r>h//gI<left><left><left>' 'Search and replace, in current buffer, selection'
  vnoremap '<leader>s' 'y:%s/<c-r>0/<c-r>0/gI<Left><Left><Left>' 'Search and replace, in current buffer, visual selection'
  nnoremap '<leader>j' '<cmd>cnext<cr>zz' 'Jump to next result from quickfix'
  nnoremap '<leader>k' '<cmd>cprev<cr>zz' 'Jump to prev result from quickfix'
  nnoremap '<c-j>' '<c-o>' 'Jump back the jump list'
  nnoremap '<c-k>' '<c-i>' 'Jump forward the jump list'
  map 's' '<NOP>' 'unmap s'
  map 'S' '<NOP>' 'unmap S'
  nnoremap 'gt'('<cmd> e ' .. os.getenv 'HOME' .. '/Projects/Notes/Todo.md<cr>') 'Open Todo file'
  local qf = require 'quickfix'
  nnoremap 'gb'(qf.buffers) 'Quickfix: List buffers'
  nnoremap 'gn'(function()
    local nu = vim.wo[vim.api.nvim_get_current_win()].number
    return '<cmd>setlocal ' .. (nu and 'no' or '') .. 'nu<cr>'
  end) { expr = true } 'Toggle line number'
  nnoremap 'gN'(function()
    local rnu = vim.wo[vim.api.nvim_get_current_win()].relativenumber
    return '<cmd>setlocal ' .. (rnu and 'no' or '') .. 'rnu<cr>'
  end) { expr = true } 'Toggle relative line number'
end

return keymaps
