local u = require("utils")
local t = require("rose-pine.theme")
local p = require("rose-pine.palette")
local ntst = {noremap = true, silent = true}

require('vgit').setup({
  debug = true,
  controller = {
    hunks_enabled = true,
    blames_enabled = true,
    diff_strategy = 'index',
    diff_preference = 'horizontal',
    predict_hunk_signs = true,
    predict_hunk_throttle_ms = 300,
    predict_hunk_max_lines = 50000,
    blame_line_throttle_ms = 150,
    show_untracked_file_signs = true,
    action_delay_ms = 300
  },
  sign = {
    VGitViewSignAdd = {
      name = 'VGitViewSignAdd',
      line_hl = 'VGitViewSignAdd',
      text_hl = nil,
      num_hl = nil,
      icon = nil,
      text = ''
    },
    VGitViewSignRemove = {
      name = 'VGitViewSignRemove',
      line_hl = 'VGitViewSignRemove',
      text_hl = nil,
      num_hl = nil,
      icon = nil,
      text = ''
    },
    VGitSignAdd = {
      name = 'VGitSignAdd',
      text_hl = 'VGitSignAdd',
      num_hl = nil,
      icon = nil,
      line_hl = nil,
      text = '┃'
    },
    VGitSignRemove = {
      name = 'VGitSignRemove',
      text_hl = 'VGitSignRemove',
      num_hl = nil,
      icon = nil,
      line_hl = nil,
      text = '┃'
    },
    VGitSignChange = {
      name = 'VGitSignChange',
      text_hl = 'VGitSignChange',
      num_hl = nil,
      icon = nil,
      line_hl = nil,
      text = '┃'
    }
  },
  hls = {
    VGitViewWordAdd = {bg = '#5d7a22', fg = p.text},
    VGitViewWordRemove = {bg = p.love, fg = p.text},
    VGitSignAdd = t.plugins.SignAdd,
    VGitSignChange = t.plugins.SignChange,
    VGitSignRemove = t.plugins.SignRemove,
    VGitIndicator = {fg = '#a6e22e', bg = nil},
    VGitStatus = {fg = '#bb9af7', bg = '#3b4261'},
    VGitBorderFocus = {fg = '#7AA6DA', bg = nil},
    VGitBorder = {fg = p.subtle, bg = nil},
    VGitBlame = {bg = nil, fg = p.highlight_overlay},
    VGitMuted = {bg = nil, fg = '#303b54'},
    VGitViewSignAdd = {bg = p.pine, fg = nil},
    VGitViewSignRemove = {bg = p.love, fg = nil}
  },
  line_blame = {
    hl = 'VGitBlame',
    format = function(blame, git_config)
      local function round(x)
        return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
      end
      local config_author = git_config['user.name']
      local author = blame.author
      if config_author == author then
        author = 'You'
      end
      local time = os.difftime(os.time(), blame.author_time) / (24 * 60 * 60)
      local time_format = string.format('%s days ago', round(time))
      local time_divisions = {{24, 'hours'}, {60, 'minutes'}, {60, 'seconds'}}
      local division_counter = 1
      while time < 1 and division_counter ~= #time_divisions do
        local division = time_divisions[division_counter]
        time = time * division[1]
        time_format = string.format('%s %s ago', round(time), division[2])
        division_counter = division_counter + 1
      end
      local commit_message = blame.commit_message
      if not blame.committed then
        author = 'You'
        commit_message = 'Uncommitted changes'
        local info = string.format('%s • %s', author, commit_message)
        return string.format(' %s', info)
      end
      local max_commit_message_length = 255
      if #commit_message > max_commit_message_length then
        commit_message = commit_message:sub(1, max_commit_message_length) ..
                             '...'
      end
      local info = string.format('%s, %s • %s', author, time_format,
                                 commit_message)
      return string.format(' %s', info)
    end
  }
})

-- u.kmap('n', '<leader>gp', ':VGit buffer_hunk_preview<CR>', ntst)
-- u.kmap('n', '<leader>gr', ':VGit hunk_reset<CR>', ntst)
-- u.kmap('n', '<leader>gk', ':VGit hunk_up<CR>', ntst)
-- u.kmap('n', '<leader>gj', ':VGit hunk_down<CR>', ntst)
-- u.kmap('n', '<leader>gf', ':VGit buffer_diff_preview<CR>', ntst)
-- u.kmap('n', '<leader>gh', ':VGit buffer_history_preview<CR>', ntst)
-- u.kmap('n', '<leader>gu', ':VGit buffer_reset<CR>', ntst)
-- u.kmap('n', '<leader>gd', ':VGit diff<CR>', ntst)
-- u.kmap('n', '<leader>gq', ':VGit hunks_quickfix_list<CR>', ntst)
