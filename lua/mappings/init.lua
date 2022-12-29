local keymaps = {}

keymaps.setup = function()
  local nnoremap = require('mappings.hashish').nnoremap
  local vnoremap = require('mappings.hashish').vnoremap
  local inoremap = require('mappings.hashish').inoremap
  local xnoremap = require('mappings.hashish').xnoremap

  -- Leader bindings
  local silent = { silent = true }
  nnoremap '<Space>' '<NOP>'(silent) 'Leader key'
  vim.g.mapleader = ' '

  nnoremap '<leader>w' '<cmd>up<cr>'(silent) 'Save file (only if modified)'
  inoremap 'jk' '<Esc>' {} 'Escape insert mode'
  inoremap 'kj' '<Esc>' {} 'Escape insert mode'
  nnoremap '<leader>q' '<cmd>q<cr>'(silent) 'Close window (:q)'
  nnoremap '<leader>Q' '<cmd>qa<cr>'(silent) 'Quit all (:qa)'
  nnoremap '<leader>e' '<cmd>Explorer<cr>' {} 'Toggle file explorer'
  nnoremap 'H' '^' {} 'Jump to the start of the line'
  xnoremap 'H' '^' {} 'Jump to the start of the line'
  nnoremap 'L' 'g_' {} 'Jump to the end of the line'
  xnoremap 'L' 'g_' {} 'Jump to the end of the line'
  nnoremap 'gh' ':wincmd h<cr>'(silent) 'Create new window to the left'
  nnoremap 'gl' ':wincmd l<cr>'(silent) 'Create new window to the right'
  nnoremap 'gj' ':wincmd j<cr>'(silent) 'Create new window below'
  nnoremap 'gk' ':wincmd k<cr>'(silent) 'Create new window above'
  vnoremap 'J' ":m '>+1<CR>gv=gv"(silent) 'Move selected lines down'
  vnoremap 'K' ":m '<-2<CR>gv=gv"(silent) 'Move selected lines up'
  nnoremap 'X' ':bd<cr>'(silent) 'Close current buffer'
  nnoremap ')' ':vertical resize +5<cr>'(silent) 'Increase current window height'
  nnoremap '(' ':vertical resize -5<cr>'(silent) 'Decrease current window height'
  nnoremap '+' ':res +1<cr>'(silent) 'Increase current window width'
  nnoremap '-' ':res -1<cr>'(silent) 'Decrease current window width'
  vnoremap '<' '<gv' {} 'Maintain visual selection while decreasing indent'
  vnoremap '>' '>gv' {} 'Maintain visual selection while increasing indent'
  vnoremap '=' '=gv' {} 'Maintain visual selection while auto fixing indent'
  nnoremap '<leader>y' 'gg"+yG'(silent) 'Yank whole buffer'
  nnoremap '<leader>v' 'ggVG'(silent) 'Select whole buffer'
  vnoremap 'p' '"_dP' {} 'Paste inplace without yanking selected text'
  nnoremap '<TAB>' ':bnext<cr>'(silent) 'Focus next buffer'
  nnoremap '<S-TAB>' ':bprevious<cr>'(silent) 'Focus previous buffer'
  nnoremap '<leader>n' '<cmd>cn<cr>' {} 'Navigate to next quickfix item'
  nnoremap '<leader>p' '<cmd>cp<cr>' {} 'Navigate to prev quickfix item'
  nnoremap '<leader>c' '<cmd>copen<cr>' {} 'Open quickfix'
  nnoremap 'gF' ':e <cfile><cr>'(silent) "Open path to file under cursor even if it doesn't exist"
  nnoremap 'n' 'nzzzv' {} 'Jump to next match and center line'
  nnoremap 'N' 'Nzzzv' {} 'Jump to previous match and center line'
  nnoremap 'J' 'mzJ`z' {} 'Join lines without moving cursor'
  nnoremap '}' '}zzzv' {} 'Like text object motion } but centers line'
  nnoremap '{' '{zzzv' {} 'Like text object motion { but centers line'
  nnoremap '<leader>r' ':%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<Left><Left><Left>' {} 'Search and replace, in current buffer, word under cursor'
  vnoremap '<leader>s' 'y:%s/<c-r>0/<c-r>0/gI<Left><Left><Left>' {} 'Search and replace, in current buffer, visual selection'
  nnoremap '<leader>j' '<cmd>cnext<cr>zz' {} 'Jump to next result from quickfix'
  nnoremap '<leader>k' '<cmd>cprev<cr>zz' {} 'Jump to prev result from quickfix'
end

return keymaps
