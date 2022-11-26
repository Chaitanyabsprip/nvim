local M = {}

M.keymaps = {}

M.nmap = function(key)
  return M.map 'n' (key)
end

M.vmap = function(key)
  return M.map 'v' (key)
end

M.nnoremap = function(key)
  return M.noremap 'n' (key)
end

M.vnoremap = function(key)
  return M.noremap 'v' (key)
end

M.tnoremap = function(key)
  return M.noremap 't' (key)
end

M.xnoremap = function(key)
  return M.noremap 'x' (key)
end

M.inoremap = function(key)
  return M.noremap 'i' (key)
end

M.noremap = function(mode)
  return function(key)
    return function(command)
      return function(options)
        options = vim.tbl_extend('force', options, { noremap = true })
        return M.map(mode)(key)(command)(options)
      end
    end
  end
end

M.map = function(mode)
  return function(key)
    return function(command)
      return function(options)
        return function(description)
          options = vim.tbl_extend('force', options, { desc = description })
          options.buffer = options.bufnr
          options.bufnr = nil
          return vim.keymap.set(mode, key, command, options)
          -- return M.register_keymap(mode, key, command, options, description)
        end
      end
    end
  end
end

M.register_keymap = function(mode, key, command, options, description)
  M.keymaps[mode] = M.keymaps[mode] or {}
  M.keymaps[mode][key] = {
    mode = mode,
    key = key,
    command = command,
    options = options,
    description = description or '',
  }
end

M.setup_keymaps = function(keymaps)
  keymaps = keymaps or M.keymaps
  for _, mode in pairs(keymaps) do
    for _, keymap in pairs(mode) do
      vim.keymap.set(keymap.mode, keymap.key, keymap.command, keymap.options)
    end
  end
end

M.call = function()
  local nmap = M.nmap
  local nnoremap = M.nnoremap
  local inoremap = M.inoremap
  local tnoremap = M.tnoremap
  local vnoremap = M.vnoremap
  local xnoremap = M.xnoremap

  -- j/k will move virtual lines (lines that wrap)
  nnoremap 'j' "(v:count == 0 ? 'gj' : 'j')" { expr = true } 'Move to next virtual/real line'
  nnoremap 'k' "(v:count == 0 ? 'gk' : 'k')" { expr = true } 'Move to previous virtual/real line'

  -- easy command mode
  nnoremap ';' ':' {} 'Quick command mode'
  nnoremap ':' ';' {} 'Quick command mode adjustment'
  vnoremap ';' ':' {} 'Quick command mode'
  vnoremap ':' ';' {} 'Quick command mode adjustment'

  -- Go to start or end of line easier
  nnoremap 'H' '^' {} 'Go to the start of the line'
  xnoremap 'H' '^' {} 'Go to the start of the line'
  nnoremap 'L' 'g_' {} 'Go to the end of the line'
  xnoremap 'L' 'g_' {} 'Go to the end of the line'

  -- I hate escape more than anything else
  inoremap 'jk' '<Esc>' {} 'Escape insert mode'
  inoremap 'kj' '<Esc>' {} 'Escape insert mode'

  -- terminal binds
  tnoremap '<Esc>' '<C-\\><C-n>' {} 'Escape insert mode'
  tnoremap '<A-[>' '<C-\\><C-n>' {} 'Escape insert mode'
  tnoremap 'jk' '<C-\\><C-n>' {} 'Escape insert mode'
  tnoremap 'kj' '<C-\\><C-n>' {} 'Escape insert mode'

  -- move lines up and down
  nnoremap '<M-j>' ':m .+1<cr>==' { silent = true } 'Move current line down'
  nnoremap '<M-k>' ':m .-2<cr>==' { silent = true } 'Move current line up'
  inoremap '<M-j>' '<Esc>:m .+1<cr>==gi' { silent = true } 'Move current line down'
  inoremap '<M-k>' '<Esc>:m .-2<cr>==gi' { silent = true } 'Move current line up'
  vnoremap '<M-j>' ":m '>+1<cr>gv=gv" { silent = true } 'Move current line down'
  vnoremap '<M-k>' ":m '<-2<cr>gv=gv" { silent = true } 'Move current line up'

  -- better yank
  vnoremap 'p' '"_dP' {} 'Paste inplace without yanking selected text'

  -- better undo breakpoints
  inoremap ',' ',<C-g>U' {} 'Introduce undo breakpoint'
  inoremap '.' '.<C-g>U' {} 'Introduce undo breakpoint'
  inoremap '!' '!<C-g>U' {} 'Introduce undo breakpoint'
  inoremap '?' '?<C-g>U' {} 'Introduce undo breakpoint'

  -- sort
  vnoremap 'gs' ':sort<cr>' {} 'Sort lines'

  -- better search/block jumping and line joining
  nnoremap 'n' 'nzzzv' {} 'Jump to next match and center line'
  nnoremap 'N' 'Nzzzv' {} 'Jump to previous match and center line'
  nnoremap 'J' 'mzJ`z' {} 'Join lines without moving cursor'
  nnoremap '}' '}zzzv' {} 'like text object motion } but centers line'
  nnoremap '{' '{zzzv' {} 'like text object motion { but centers linene'

  -- add blank lines on top or bottom of the current line
  nnoremap '<a-s-j>' 'o<Esc>k' {} 'Add blank line below current line'
  nnoremap '<a-s-k>' 'O<Esc>j' {} 'Add blank line above current line'

  -- better indent
  vnoremap '<' '<gv' {} 'Maintain visual selection while decreasing indent'
  vnoremap '>' '>gv' {} 'Maintain visual selection while increasing indent'
  vnoremap '=' '=gv' {} 'Maintain visual selection while auto fixing indent'

  -- Leader bindings
  nnoremap '<Space>' '<NOP>' { silent = true } 'Leader key'
  vim.g.mapleader = ' '

  -- save file
  nnoremap '<leader>w' ':up<cr>' { silent = true } 'Save file (only if modified)'

  ------------------------------------------------------------------------
  -- Windows keymap
  ------------------------------------------------------------------------
  -- move between open windows
  -- nnoremap '<c-h>' ':wincmd h<cr>' { silent = true } 'Move cursor to left window'
  -- nnoremap '<c-j>' ':wincmd j<cr>' { silent = true } 'Move cursor to window above'
  -- nnoremap '<c-k>' ':wincmd k<cr>' { silent = true } 'Move cursor to window below'
  -- nnoremap '<c-l>' ':wincmd l<cr>' { silent = true } 'Move cursor to right window'
  nnoremap '<leader>h' ':wincmd h<cr>' { silent = true } 'Create new window to the left'
  nnoremap '<leader>l' ':wincmd l<cr>' { silent = true } 'Create new window to the right'
  nnoremap '<leader>j' ':wincmd j<cr>' { silent = true } 'Create new window below'
  nnoremap '<leader>k' ':wincmd k<cr>' { silent = true } 'Create new window above'

  -- move windows accordingly
  nnoremap '<leader>H' ':wincmd H<cr>' { silent = true } 'Move the current window to be at the far left'
  nnoremap '<leader>J' ':wincmd J<cr>' { silent = true } 'Move the current window to be at the bottom'
  nnoremap '<leader>K' ':wincmd K<cr>' { silent = true } 'Move the current window to be at the top'
  nnoremap '<leader>L' ':wincmd L<cr>' { silent = true } 'Move the current window to be at the far right'

  -- create new windows
  -- nnoremap '<leader>h' ':vne<cr><c-w>r' { silent = true } 'Create new window to the left'
  -- nnoremap '<leader>l' ':vne<cr>' { silent = true } 'Create new window to the right'
  -- nnoremap '<leader>j' ':bel new<cr>' { silent = true } 'Create new window below'
  -- nnoremap '<leader>k' ':abo new<cr>' { silent = true } 'Create new window above'

  -- close current window
  nnoremap '<leader>q' ':qa<cr>' { silent = true } 'Quit all'
  nnoremap '<leader>x' ':bd<cr>' { silent = true } 'Close current buffer'
  nnoremap '<leader>Q' ':bufdo bdelete<cr>' { silent = true } 'Close all buffers'

  -- window resize
  nnoremap ')' ':vertical resize +5<cr>' { silent = true } 'Increase current window height'
  nnoremap '(' ':vertical resize -5<cr>' { silent = true } 'Decrease current window height'
  nnoremap '+' ':res +1<cr>' { silent = true } 'Increase current window width'
  nnoremap '-' ':res -1<cr>' { silent = true } 'Decrease current window width'

  -- TAB in normal mode will move to text buffer
  nnoremap '<TAB>' ':bnext<cr>' { silent = true } 'Focus next buffer'
  nnoremap '<S-TAB>' ':bprevious<cr>' { silent = true } 'Focus previous buffer'
  nnoremap 'gF' ':tabe <cfile><cr>' { silent = true } 'Open path to file under cursor in new tab'

  -- refresh buffer, reads the current file from disk. Helps refresh Lsp and other buffer plugins
  nnoremap '<C-e>' ':e!<cr>' { silent = true } 'Refresh buffer'

  -- spell
  nnoremap '<F11>' ':set spell!<cr>' { silent = true } 'Enable spell checking'
  inoremap '<F11>' '<C-O>:set spell!<cr>' { silent = true } 'Enable spell checking'

  -- surround
  nmap '<leader>`' 'viws`' {} 'Surround word under cursor with backticks'
  nmap '<leader>-' 'viwc__<Esc>hp' {} 'Surround word under cursor with __'

  nnoremap '<leader>y' 'gg"+yG' { silent = true } 'Yank whole buffer'
  nnoremap '<leader>Y' 'gvy' { silent = true } 'Yank from cursor position to end of line'
  nnoremap '<leader>v' 'ggVG' { silent = true } 'Select whole buffer'
end

return M
