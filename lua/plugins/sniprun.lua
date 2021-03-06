require('sniprun').setup {
  selected_interpreters = {}, -- " use those instead of the default for the current filetype
  repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
  repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
  interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
  -- " you can combo different display modes as desired
  display = {
    'Classic', -- "display results in the command-line  area
    'VirtualTextOk', -- "display ok results as virtual text (multiline is shortened)
    'VirtualTextErr', -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    -- "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    -- "Terminal"                 -- "display results in a vertical split
  },
  snipruncolors = {
    SniprunVirtualTextOk = {
      bg = '#66eeff',
      fg = '#000000',
      ctermbg = 'Cyan',
      cterfg = 'Black',
    },
    SniprunFloatingWinOk = { fg = '#66eeff', ctermfg = 'Cyan' },
    SniprunVirtualTextErr = {
      bg = '#881515',
      fg = '#000000',
      ctermbg = 'DarkRed',
      cterfg = 'Black',
    },
    SniprunFloatingWinErr = { fg = '#881515', ctermfg = 'DarkRed' },
  },
  inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
  borders = 'single', -- " display borders around floating windows 'none', 'single', 'double', or 'shadow'
}
