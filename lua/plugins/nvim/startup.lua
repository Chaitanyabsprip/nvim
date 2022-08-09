local M = {}

local function time()
  local clock = ' ' .. os.date '%H:%M'
  local date = ' ' .. os.date '%d-%m-%y'
  local git_branch = require('plugins.nvim.git_branch').get_git_branch()
    or 'Not in a git repository'
  return { date .. '  ' .. clock, ' ' .. git_branch }
end

local notes_path = '/Users/chaitanyasharma/Projects/Notes/Transient/'

local get_note_name = function()
  local date = os.date '%Y-%m-%d'
  return date .. '.md'
end

local new_note = function()
  return 'e ' .. notes_path .. get_note_name()
end

M.setup = function()
  local startup = require 'startup'
  local headers = require 'startup.headers'
  startup.setup {
    header = {
      type = 'text',
      oldfiles_directory = false,
      align = 'center',
      fold_section = false,
      title = 'Header',
      margin = 5,
      content = headers.hydra_header,
      highlight = 'Statement',
      default_color = '',
      oldfiles_amount = 0,
    },
    body = {
      type = 'mapping',
      oldfiles_directory = false,
      align = 'center',
      fold_section = false,
      title = 'Basic Commands',
      margin = 5,
      content = {
        { ' Find File', 'Telescope find_files', 'f' },
        { ' Find Sessions', 'SearchSession', 'p' },
        { ' Recent Files', 'Telescope oldfiles', 'm' },
        { ' Restore Session', 'RestoreSession', 'r' },
        { ' New Note', new_note(), 'n' },
        { ' Quit ', 'quit', 'q' },
      },
      highlight = 'String',
      default_color = '',
      oldfiles_amount = 0,
    },
    footer = {
      type = 'text',
      oldfiles_directory = false,
      align = 'center',
      fold_section = false,
      title = 'Footer',
      margin = 5,
      content = time(),
      highlight = 'Number',
      default_color = '',
      oldfiles_amount = 0,
    },
    options = {
      after = function()
        ---@diagnostic disable-next-line: undefined-global
        if not packer_plugins['telescope.nvim'] then
          require('packer').loader 'telescope.nvim'
        end
      end,
      cursor_column = 0.6,
      paddings = { 3, 4, 2, 0 },
    },
    parts = { 'header', 'body', 'footer' },
  }
end
return M
