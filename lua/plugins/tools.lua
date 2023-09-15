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
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and require('obsidian').util.table_length(note.metadata) > 0 then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
    }
  end,
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
