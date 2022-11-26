local prequire = require('utils').preq
local luasnip = prequire 'luasnip'

local M = {}

M.setup = function()
  local types = require 'luasnip.util.types'
  luasnip.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = true,
    ext_opts = {
      [types.choiceNode] = { active = { virt_text = { { '●', 'Error' } } } },
      [types.insertNode] = {
        active = { virt_text = { { '●', 'Comment' } } },
      },
    },
  }
  require('luasnip.loaders.from_vscode').lazy_load()
  -- local t = function(str)
  --   return vim.api.nvim_replace_termcodes(str, true, true, true)
  -- end
  --
  -- local check_backspace = function()
  --   local col = vim.fn.col '.' - 1
  --   ---@diagnostic disable-next-line: param-type-mismatch, undefined-field
  --   return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
  -- end
  --
  -- _G.tab_complete = function()
  --   if cmp and cmp.visible() then
  --     cmp.select_next_item()
  --   elseif luasnip and luasnip.expand_or_jumpable() then
  --     return t '<Plug>luasnip-expand-or-jump'
  --   elseif check_backspace() then
  --     return t '<Tab>'
  --   else
  --     cmp.complete()
  --   end
  --   return ''
  -- end
  --
  -- _G.s_tab_complete = function()
  --   if cmp and cmp.visible() then
  --     cmp.select_prev_item()
  --   elseif luasnip and luasnip.jumpable(-1) then
  --     return t '<Plug>luasnip-jump-prev'
  --   else
  --     return t '<S-Tab>'
  --   end
  --   return ''
  -- end
  --
  -- vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  -- vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  -- vim.api.nvim_set_keymap(
  --   'i',
  --   '<S-Tab>',
  --   'v:lua.s_tab_complete()',
  --   { expr = true }
  -- )
  -- vim.api.nvim_set_keymap(
  --   's',
  --   '<S-Tab>',
  --   'v:lua.s_tab_complete()',
  --   { expr = true }
  -- )
  -- vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>luasnip-next-choice', {})
  -- vim.api.nvim_set_keymap('s', '<C-E>', '<Plug>luasnip-next-choice', {})
end

return M
