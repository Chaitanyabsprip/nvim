local tools = {}

tools.colorizer = {
  'NvChad/nvim-colorizer.lua',
  cmd = { 'ColorizerAttachToBuffer', 'ColorizerToggle' },
  event = 'BufReadPre',
  opts = {
    filetypes = { '*', '!lazy' },
    buftypes = { '*', '!prompt', '!nofile' },
    user_default_options = {
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      css_fn = true,
      mode = 'background', -- Available modes for `mode`: foreground, background,  virtualtext
      virtualtext = '███',
    },
  },
}

tools.fish =
  { 'dag/vim-fish', ft = 'fish', cond = function() return vim.loop.fs_stat 'config.fish' end }

tools.obsidian = {
  'epwalsh/obsidian.nvim',
  cmd = {
    'ObsidianNew',
    'ObsidianSearch',
    'Today',
    'Yesterday',
    'Notes',
    'SearchNotes',
  },
  ft = { 'md', 'markdown', 'rmd', 'rst' },
  keys = {
    {
      'gf',
      function()
        return require('obsidian').util.cursor_on_markdown_link() and '<cmd>ObsidianFollowLink<CR>'
          or 'gf'
      end,
      expr = true,
      desc = 'Notes: Open link or file under cursor',
    },
  },
  opts = function()
    local command = vim.api.nvim_create_user_command
    command('Today', 'ObsidianToday', {})
    command('Yesterday', 'ObsidianYesterday', {})
    command('SearchNotes', 'ObsidianSemanticSearch', {})
    command('Notes', 'ObsidianSemanticSearch', {})
    return {
      dir = '~/Projects/Notes',
      -- Optional, if you keep notes in a specific subdirectory of your vault.
      notes_subdir = 'transient',
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_notes_location = 'notes_subdir',
      },
      daily_notes = {
        folder = 'transient',
        date_format = '%Y-%m-%d',
      },
      mappings = {},
      -- Optional, alternatively you can customize the frontmatter data.
      follow_url_func = function(url) vim.fn.jobstart { 'open', url } end,
      use_advanced_uri = true,
      open_app_foreground = true,
      finder = 'telescope.nvim',
      disable_frontmatter = true,
    }
  end,
}

tools.peek = {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  keys = {
    {
      '<leader>op',
      function()
        local peek = require 'peek'
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      desc = 'Peek (Markdown Preview)',
    },
  },
  opts = { app = 'browser' },
}

tools.startuptime = {
  'dstein64/vim-startuptime',
  config = function() vim.g.startuptime_tries = 50 end,
  cmd = 'StartupTime',
}

tools.spec = {
  tools.colorizer,
  tools.fish,
  tools.obsidian,
  tools.peek,
  tools.startuptime,
}

return tools.spec
