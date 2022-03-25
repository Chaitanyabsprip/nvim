require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'dart',
    'elixir',
    'elm',
    'erlang',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'kotlin',
    'lua',
    'python',
    'ruby',
    'rust',
    'scala',
    'swift',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ['group'] = 'PreProc',
      -- ['test'] = 'PreProc',
    },
  },
  indent = { enable = true },
  rainbow = { enable = false },
  autopairs = { enable = true },
  autotag = { enable = true },
  matchup = { enable = true },
  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = 'grr' } },
    highlight_definitions = { enable = true },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = 'gnd',
        -- use telescope for these lists
        -- list_definitions = "gnD",
        -- list_definitions_toc = "gO",
        -- @TODOUA: figure out if I need both below
        goto_next_usage = '<a-*>', -- is this redundant?
        goto_previous_usage = '<a-#>', -- also this one?
      },
    },
    highlight_current_scope = { enable = true },
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ['<leader>dp'] = '@function.outer',
        ['<leader>dP'] = '@class.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@call.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@call.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@call.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@call.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        [',a'] = '@parameter.inner',
      },
      swap_previous = {
        [',A'] = '@parameter.inner',
      },
    },
  },
}
