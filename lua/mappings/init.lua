local keymaps = {}

keymaps.setup = function()
  local nnoremap = require('mappings.hashish').nnoremap
  local vnoremap = require('mappings.hashish').vnoremap
  local inoremap = require('mappings.hashish').inoremap
  local xnoremap = require('mappings.hashish').xnoremap

  -- Leader bindings
  nnoremap '<Space>' '<NOP>' { silent = true } 'Leader key'
  vim.g.mapleader = ' '

  nnoremap '<leader>w' '<cmd>up<cr>' { silent = true } 'Save file (only if modified)'
  inoremap 'jk' '<Esc>' {} 'Escape insert mode'
  inoremap 'kj' '<Esc>' {} 'Escape insert mode'
  inoremap 'jj' '<Esc>' {} 'Escape insert mode'
  inoremap 'kk' '<Esc>' {} 'Escape insert mode'
  nnoremap '<leader>q' '<cmd>q<cr>' { silent = true } 'Quit all'
  nnoremap '<leader>Q' '<cmd>qa<cr>' { silent = true } 'Quit all'
  -- nnoremap ';' ':' {} 'Quick command mode'
  -- nnoremap ':' ';' {} 'Quick command mode adjustment'
  -- vnoremap ';' ':' {} 'Quick command mode'
  -- vnoremap ':' ';' {} 'Quick command mode adjustment'
  nnoremap '<leader>e' '<cmd>Explorer<cr>' {} 'Toggle file explorer'
  nnoremap 'H' '^' {} 'Jump to the start of the line'
  xnoremap 'H' '^' {} 'Jump to the start of the line'
  nnoremap 'L' 'g_' {} 'Jump to the end of the line'
  xnoremap 'L' 'g_' {} 'Jump to the end of the line'
  nnoremap '<leader>h' ':wincmd h<cr>' { silent = true } 'Create new window to the left'
  nnoremap '<leader>l' ':wincmd l<cr>' { silent = true } 'Create new window to the right'
  nnoremap '<leader>j' ':wincmd j<cr>' { silent = true } 'Create new window below'
  nnoremap '<leader>k' ':wincmd k<cr>' { silent = true } 'Create new window above'
  nnoremap '<leader>x' ':bd<cr>' { silent = true } 'Close current buffer'
  nnoremap ')' ':vertical resize +5<cr>' { silent = true } 'Increase current window height'
  nnoremap '(' ':vertical resize -5<cr>' { silent = true } 'Decrease current window height'
  nnoremap '+' ':res +1<cr>' { silent = true } 'Increase current window width'
  nnoremap '-' ':res -1<cr>' { silent = true } 'Decrease current window width'
  vnoremap '<' '<gv' {} 'Maintain visual selection while decreasing indent'
  vnoremap '>' '>gv' {} 'Maintain visual selection while increasing indent'
  vnoremap '=' '=gv' {} 'Maintain visual selection while auto fixing indent'
  nnoremap '<leader>y' 'gg"+yG' { silent = true } 'Yank whole buffer'
  nnoremap '<leader>v' 'ggVG' { silent = true } 'Select whole buffer'
  vnoremap 'p' '"_dP' {} 'Paste inplace without yanking selected text'
  nnoremap '<TAB>' ':bnext<cr>' { silent = true } 'Focus next buffer'
  nnoremap '<S-TAB>' ':bprevious<cr>' { silent = true } 'Focus previous buffer'
  nnoremap 'gF' ':tabe <cfile><cr>' { silent = true } 'Open path to file under cursor in new tab'
  nnoremap 'n' 'nzzzv' {} 'Jump to next match and center line'
  nnoremap 'N' 'Nzzzv' {} 'Jump to previous match and center line'
  nnoremap 'J' 'mzJ`z' {} 'Join lines without moving cursor'
  nnoremap '}' '}zzzv' {} 'like text object motion } but centers line'
  nnoremap '{' '{zzzv' {} 'like text object motion { but centers line'
  nnoremap '<leader>sr' ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>' {} 'search and replace word under cursor'
end

return keymaps
