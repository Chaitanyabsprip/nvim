require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["group"] = "PreProc",
      ["test"] = "PreProc"
    }
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  },
  refactor = {
    -- highlight_current_scope = {enable = true},
    highlight_definition = {enable = true},
    navigation = {enable = true},
    smart_rename = {enable = true}
  },
  -- nvim-ts-rainbow For rainbow parenthesis
  rainbow = {enable = true},
  autopairs = {enable = true},
  -- indent = {enable = true},
  autotag = {enable = true},
  ensure_installed = {
    'python', 'dart', 'java', 'c', 'ruby', 'go', 'yaml', 'bash', 'jsonc',
    'clojure', 'lua', 'scss', 'json', 'html', 'kotlin', 'rust',
    'c_sharp', 'cpp', 'typescript', 'comment'
  }
}
