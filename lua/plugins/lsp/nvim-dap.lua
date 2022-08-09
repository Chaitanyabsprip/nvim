local nnoremap = require('utils').nnoremap
local api = vim.api
local keymap_restore = {}
local dap = require 'dap'

dap.set_log_level 'DEBUG'
dap.listeners.after['event_initialized']['me'] = function()
  for _, buf in pairs(api.nvim_list_bufs()) do
    local keymaps = api.nvim_buf_get_keymap(buf, 'n')
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == '<a-k>' then
        table.insert(keymap_restore, keymap)
        api.nvim_buf_del_keymap(buf, 'n', '<a-k>')
      end
    end
  end
  api.nvim_set_keymap(
    'n',
    '<a-k>',
    '<Cmd>lua require("dap.ui.variables").hover()<CR>',
    { silent = true }
  )
end

dap.listeners.after['event_terminated']['me'] = function()
  for _, keymap in pairs(keymap_restore) do
    api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end

dap.listeners.after.event_initialized['dapui_config'] = function()
  require('dapui').open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  require('dapui').close()
end

nnoremap(
  '<leader>dcm',
  "<CMD>lua require'telescope'.extensions.dap.commands{}<CR>",
  true
)
nnoremap(
  '<leader>dcf',
  "<CMD>lua require'telescope'.extensions.dap.configurations{}<CR>",
  true
)
nnoremap(
  '<leader>dlb',
  "<CMD>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
  true
)
nnoremap(
  '<leader>dv',
  "<CMD>lua require'telescope'.extensions.dap.variables{}<CR>",
  true
)
nnoremap(
  '<leader>df',
  "<CMD>lua require'telescope'.extensions.dap.frames{}<CR>",
  true
)
nnoremap('<leader>b', "<CMD>lua require'dap'.toggle_breakpoint()<CR>", true)
nnoremap(
  '<leader>B',
  "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
  true
)
nnoremap('<leader>c', "<CMD>lua require'dap'.continue()<CR>", true)
nnoremap('<C-U>', "<CMD>lua require'dap'.step_over()<CR>", true)
nnoremap('<C-O>', "<CMD>lua require'dap'.step_out()<CR>", true)
nnoremap('<C-I>', "<CMD>lua require'dap'.step_into()<CR>", true)
nnoremap('<leader>ro', "<CMD>lua require'dap'.repl.open()<CR>", true)
