local nnoremap = require('utils').nnoremap
local onoremap = require('utils').onoremap
local map = require('utils').map

require('hop').setup {
  jump_on_sole_occurrence = true,
  keys = 'jdsaklghxcvbnmwertyuiof',
}

vim.cmd [[ hi! HopNextKey2 guifg=#449dab]]

local nFmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
local nfmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
local ofmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
local oFmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
local tmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
local Tmap_command =
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
nnoremap('<c-f>', "<cmd>lua require'hop'.hint_char1()<cr>", true)
nnoremap('<c-g>', "<cmd>lua require'hop'.hint_words()<cr>", true)
nnoremap('f', nfmap_command, true)
nnoremap('F', nFmap_command, true)
onoremap('f', ofmap_command, true)
onoremap('F', oFmap_command, true)
map('', 't', tmap_command, { noremap = true, silent = true })
map('', 'T', Tmap_command, { noremap = true, silent = true })
