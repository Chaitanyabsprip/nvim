local config = {
  theme = {
    name = 'catpuccin',
    transparent = true,
    hide_eob = true,
    comments = { 'italic' },
    functions = { 'italic' },
    keywords = { 'italic' },
    strings = {},
    variables = { 'italic' },
    italics = {
      comments = true,
      functions = true,
      keywords = true,
      strings = false,
      variables = true,
    },
    sidebars = {
      'UltestSummary',
      'terminal',
      'packer',
      'qf',
      'neofs',
      'nvim-tree',
      'lir',
      'JABS',
    },
  },
}

return config
