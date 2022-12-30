local keymaps = {}

keymaps.setup = function()
  local hashish = require 'mappings.hashish'
  local nnoremap = hashish.nnoremap
  local vnoremap = hashish.vnoremap
  local inoremap = hashish.inoremap
  local xnoremap = hashish.xnoremap

  -- Leader bindings
  nnoremap '<Space>' '<NOP>' 'Leader key'
  vim.g.mapleader = ' '

  nnoremap '<leader>w' '<cmd>up<cr>' 'Save file (only if modified)'
  inoremap 'jk' '<esc>' 'Escape insert mode'
  inoremap 'kj' '<esc>' 'Escape insert mode'
  inoremap '<c-c>' '<esc>' 'Escape insert mode'
  nnoremap '<leader>q' '<cmd>q<cr>' 'Close window (:q)'
  nnoremap '<leader>Q' '<cmd>qa<cr>' 'Quit all (:qa)'
  nnoremap '<leader>e' '<cmd>Explorer<cr>' 'Toggle file explorer'
  nnoremap 'H' '^' 'Jump to the start of the line'
  xnoremap 'H' '^' 'Jump to the start of the line'
  nnoremap 'L' 'g_' 'Jump to the end of the line'
  xnoremap 'L' 'g_' 'Jump to the end of the line'
  nnoremap 'gh' '<cmd>wincmd h<cr>' 'Create new window to the left'
  nnoremap 'gl' '<cmd>wincmd l<cr>' 'Create new window to the right'
  nnoremap 'gj' '<cmd>wincmd j<cr>' 'Create new window below'
  nnoremap 'gk' '<cmd>wincmd k<cr>' 'Create new window above'
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
  nnoremap '<leader>y' 'gg"+yG' 'Yank whole buffer to system clipboard'
  nnoremap '<leader>v' 'ggVG' 'Select whole buffer'
  vnoremap 'p' '"_dP' 'Paste inplace without yanking selected text'
  nnoremap '<TAB>' '<cmd>bnext<cr>' 'Focus next buffer'
  nnoremap '<S-TAB>' '<cmd>:bprevious<cr>' 'Focus previous buffer'
  nnoremap '<leader>c' '<cmd>copen<cr>' 'Open quickfix'
  nnoremap 'gF' '<cmd>e <cfile><cr>' "Open path to file under cursor even if it doesn't exist"
  nnoremap 'n' 'nzzzv' 'Jump to next match and center line'
  nnoremap 'N' 'Nzzzv' 'Jump to previous match and center line'
  nnoremap 'J' 'mzJ`z' 'Join lines without moving cursor'
  nnoremap '}' '}zzzv' 'Like text object motion } but centers line'
  nnoremap '{' '{zzzv' 'Like text object motion { but centers line'
  nnoremap '<leader>r' ':%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<Left><Left><Left>' 'Search and replace, in current buffer, word under cursor'
  vnoremap '<leader>s' 'y:%s/<c-r>0/<c-r>0/gI<Left><Left><Left>' 'Search and replace, in current buffer, visual selection'
  nnoremap '<leader>j' '<cmd>cnext<cr>zz' 'Jump to next result from quickfix'
  nnoremap '<leader>k' '<cmd>cprev<cr>zz' 'Jump to prev result from quickfix'
end

return keymaps
