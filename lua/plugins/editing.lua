local M = {}
local nnoremap = require('mappings').nnoremap

M.hop = function()
  require('hop').setup {
    jump_on_sole_occurrence = true,
    keys = 'nrsaeogpcldkbhvwmjzfuxt',
  }
  vim.cmd [[ hi! HopNextKey2 guifg=#449dab]]
  nnoremap '<c-f>' "<cmd>lua require'hop'.hint_char1()<cr>" { silent = true } 'Initiate hop with 1 character search'
  nnoremap '<c-g>' "<cmd>lua require'hop'.hint_words()<cr>" { silent = true } 'Initiate hop to words'
end

M.autopairs = function()
  require('nvim-autopairs').setup()
  local inoremap = require('mappings').inoremap
  local npairs = require 'nvim-autopairs'

  _G.MUtils = {}

  vim.g.completion_confirm_key = '<CR>'
  MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()['selected'] ~= -1 then
        return vim.fn['compe#confirm'](npairs.esc '<cr>')
      else
        return npairs.esc '<cr>'
      end
    else
      return npairs.autopairs_cr()
    end
  end

  inoremap '<cr>' 'v:lua.MUtils.completion_confirm()' { expr = true }
end

M.todo_comments = function()
  require('todo-comments').setup {
    keywords = {
      FIX = {
        icon = ' ',
        color = 'error',
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'XXX' },
      },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
    },
  }
end

M.workman = function()
  function Workman(workman, qwerty)
    workman = workman or { normal = 0, insert = 0 }
    qwerty = qwerty or { normal = 0, insert = 0 }
    vim.g.workman_normal_workman = workman.normal
    vim.g.workman_insert_workman = workman.insert
    vim.g.workman_normal_qwerty = qwerty.normal
    vim.g.workman_insert_qwerty = qwerty.insert
  end

  Workman()
end

M.search_and_replace = function()
  require('spectre').setup {
    color_devicons = true,
    open_cmd = 'vnew',
    live_update = false, -- auto excute search again when you write any file in vim
    line_sep_start = '┌-----------------------------------------',
    result_padding = '¦  ',
    line_sep = '└-----------------------------------------',
    highlight = {
      ui = 'String',
      search = 'DiffChange',
      replace = 'DiffDelete',
    },
    mapping = {
      ['toggle_line'] = {
        map = 'dd',
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = 'toggle current item',
      },
      ['enter_file'] = {
        map = '<cr>',
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = 'goto current file',
      },
      ['send_to_qf'] = {
        map = '<leader>q',
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = 'send all item to quickfix',
      },
      ['replace_cmd'] = {
        map = '<leader>c',
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = 'input replace vim command',
      },
      ['show_option_menu'] = {
        map = '<leader>o',
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = 'show option',
      },
      ['run_replace'] = {
        map = '<leader>R',
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = 'replace all',
      },
      ['change_view_mode'] = {
        map = '<leader>v',
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = 'change result view mode',
      },
      ['toggle_live_update'] = {
        map = 'tu',
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = 'update change when vim write file.',
      },
      ['toggle_ignore_case'] = {
        map = 'ti',
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = 'toggle ignore case',
      },
      ['toggle_ignore_hidden'] = {
        map = 'th',
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = 'toggle search hidden',
      },
      -- you can put your mapping here it only use normal mode
    },
    find_engine = {
      -- rg is map with finder_cmd
      ['rg'] = {
        cmd = 'rg',
        -- default args
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
          -- you can put any rg search option you want here it can toggle with
          -- show_option function
        },
      },
      ['ag'] = {
        cmd = 'ag',
        args = {
          '--vimgrep',
          '-s',
        },
        options = {
          ['ignore-case'] = {
            value = '-i',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
        },
      },
    },
    replace_engine = {
      ['sed'] = {
        cmd = 'sed',
        args = nil,
      },
      options = {
        ['ignore-case'] = {
          value = '--ignore-case',
          icon = '[I]',
          desc = 'ignore case',
        },
      },
    },
    default = {
      find = {
        --pick one of item in find_engine
        cmd = 'rg',
        options = { 'ignore-case' },
      },
      replace = {
        --pick one of item in replace_engine
        cmd = 'sed',
      },
    },
    replace_vim_cmd = 'cdo',
    is_open_target_win = true, --open file on opener window
    is_insert_mode = false, -- start open panel on is_insert_mode
  }
end

return M
