---@diagnostic disable: undefined-global

local M = {}
local nnoremap = require('utils').nnoremap
local notesdir = vim.fn.expand '$HOME' .. '/Projects/Notes'

M.project = function()
  require('project_nvim').setup {
    manual_mode = false,
    detection_methods = { 'lsp', 'pattern' },
    patterns = {
      'pubspec.yaml',
      'package.json',
      'config.py',
      'setup.py',
      'cargo.toml',
      'Makefile',
      'makefile',
      '.git',
      '.gitignore',
      '_darcs',
      '.hg',
      '.bzr',
      '.svn',
    },
    ignore_lsp = { 'null-ls' },
    show_hidden = false,
    silent_chdir = true,
    datapath = vim.fn.stdpath 'data',
  }
  require('telescope').load_extension 'projects'
end

M.lir = function()
  local actions = require 'lir.actions'
  local mark_actions = require 'lir.mark.actions'
  local clipboard_actions = require 'lir.clipboard.actions'
  require('lir').setup {
    show_hidden_files = true,
    mappings = {
      ['l'] = actions.edit,
      ['<cr>'] = actions.edit,
      ['<C-s>'] = actions.split,
      ['<C-v>'] = actions.vsplit,
      ['<C-t>'] = actions.tabedit,
      ['h'] = actions.up,
      ['q'] = actions.quit,
      ['A'] = actions.mkdir,
      ['a'] = actions.newfile,
      ['r'] = actions.rename,
      ['cd'] = actions.cd,
      ['Y'] = actions.yank_path,
      ['.'] = actions.toggle_show_hidden,
      ['d'] = actions.delete,
      ['<space>'] = function()
        mark_actions.toggle_mark()
        vim.cmd 'normal! j'
      end,
      ['c'] = clipboard_actions.copy,
      ['x'] = clipboard_actions.cut,
      ['p'] = clipboard_actions.paste,
    },
    -- float = {
    --   winblend = 10,
    --   curdir_window = {
    --     enable = false,
    --     highlight_dirname = false,
    --   },
    --   -- -- You can define a function that returns a table to be passed as the third
    --   -- -- argument of nvim_open_win().
    --   -- win_opts = function()
    --   --   local width = math.floor(vim.o.columns * 0.8)
    --   --   local height = math.floor(vim.o.lines * 0.8)
    --   --   return {
    --   --     border = require("lir.float.helper").make_border_opts({
    --   --       "+", "─", "+", "│", "+", "─", "+", "│",
    --   --     }, "Normal"),
    --   --     width = width,
    --   --     height = height,
    --   --     row = 1,
    --   --     col = math.floor((vim.o.columns - width) / 2),
    --   --   }
    --   -- end,
    -- },
  }
  nnoremap('<M-e>', '<cmd>lua require("lir.float").toggle(vim.fn.getcwd())<CR>')
  nnoremap(
    '<M-n>',
    "<cmd>lua require('lir.float').toggle('" .. notesdir .. "')<CR>"
  )
end

M.neofs = function()
  require('neofs').setup {
    devicons = true,
    mappings = {
      ['r'] = function(_)
        NeofsRename()
      end,
      ['a'] = function(_)
        NeofsCreateFile()
      end,
      ['A'] = function(_)
        NeofsCreateDirectory()
      end,
      ['d'] = function(fm)
        if fm.navigator.item().type == 'directory' then
          NeofsDelete(true)
        else
          NeofsDelete(false)
        end
      end,
    },
  }
  nnoremap('<leader>FF', "<cmd>lua require('neofs').open()<cr>", true)
  nnoremap(
    '<leader>FN',
    "<cmd>lua require('neofs').open('" .. notesdir .. "')<cr>",
    true
  )
end

M.nvim_tree = function()
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  vim.g.nvim_add_trailing = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_indent_markers = 1
  require('nvim-tree').setup {
    auto_close = true,
    diagnostics = {
      enable = true,
      icons = { hint = '', info = '', warning = '', error = '' },
    },
    disable_netrw = true,
    hijack_cursor = false,
    hijack_netrw = true,
    ignore_ft_on_setup = {},
    open_on_setup = false,
    open_on_tab = true,
    system_open = { -- configuration options for the system open command (`s` in the tree by default)
      -- the command to run this, leaving nil should work in most cases
      cmd = nil,
      -- the command arguments as a list
      args = {},
    },
    update_cwd = false,
    update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
    },
    view = {
      width = 30,
      side = 'left',
      auto_resize = true,
      mappings = {
        custom_only = false,
        list = {
          { key = { '<CR>', '<2-LeftMouse>', 'l' }, cb = tree_cb 'edit' },
          { key = { '<2-RightMouse>', '<C-]>', 'cd' }, cb = tree_cb 'cd' },
          { key = { '<C-v>', 'v' }, cb = tree_cb 'vsplit' },
          { key = { '<C-x>', 's' }, cb = tree_cb 'split' },
          { key = { '<BS>', 'h', '<S-CR>' }, cb = tree_cb 'close_node' },
          { key = { 'o' }, cb = tree_cb 'system_open' },
        },
      },
    },
  }
  nnoremap('<leader>e', ':NvimTreeToggle<CR>', true)
  nnoremap('<leader>n', '<CMD>NvimTreeFindFile<CR>', true)
end

M.snap = function()
  local snap = require 'snap'
  snap.register.map({ 'n' }, { '<leader>fg' }, function()
    snap.run {
      producer = snap.get 'consumer.limit'(
        100000,
        snap.get 'producer.ripgrep.vimgrep'
      ),
      select = snap.get('select.vimgrep').select,
      multiselect = snap.get('select.vimgrep').multiselect,
      views = { snap.get 'preview.vimgrep' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader><leader>' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.ripgrep.file'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fb' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.buffer'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fo' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.oldfile'),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
  snap.register.map({ 'n' }, { '<leader>fn' }, function()
    snap.run {
      producer = snap.get 'consumer.fzf'(
        snap.get('producer.ripgrep.file').args(
          {},
          vim.fn.expand '$HOME' .. '/Projects/Notes'
        )
      ),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
    }
  end)
end
return M
