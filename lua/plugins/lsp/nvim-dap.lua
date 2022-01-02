local nnoremap = require('utils').nnoremap
local dap = require 'dap'
local api = vim.api
local keymap_restore = {}

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

require('dapui').setup {
  sidebar = {
    elements = {
      { id = 'scopes', size = 0.25 },
      { id = 'breakpoints', size = 0.25 },
      { id = 'stacks', size = 0.25 },
      { id = 'watches', size = 00.25 },
    },
    size = 40,
    position = 'right', -- Can be "left" or "right"
  },
  tray = {
    elements = { 'repl' },
    size = 10,
    position = 'bottom', -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil,
    max_width = nil,
    mappings = { close = { 'q', '<Esc>' } },
  },
  windows = { indent = 1 },
}

nnoremap('<a-d>', "<cmd>lua require('dapui').toggle().<CR>", true)
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
nnoremap('<leader>c', "<CMD>lua require'dap'.continue()<CR>", true)
nnoremap('<leader>so', "<CMD>lua require'dap'.step_over()<CR>", true)
nnoremap('<leader>sx', "<CMD>lua require'dap'.step_out()<CR>", true)
nnoremap('<leader>si', "<CMD>lua require'dap'.step_into()<CR>", true)
nnoremap('<leader>ro', "<CMD>lua require'dap'.repl_open()<CR>", true)
