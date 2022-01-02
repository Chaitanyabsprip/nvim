local M = {}

M.blue_moon = function()
  vim.cmd [[ colorscheme blue-moon ]]
end

M.calvera = function()
  vim.g.calvera_italic_comments = true
  vim.g.calvera_italic_keywords = true
  vim.g.calvera_italic_functions = true
  vim.g.calvera_italic_variables = false
  vim.g.calvera_borders = true
  vim.g.calvera_contrast = true
  vim.g.calvera_hide_eob = true
  vim.g.calvera_disable_background = false
  vim.g.transparent_bg = false
  require('calvera').set()
end

M.catppuccin = function()
  local catppuccin = require 'catppuccin'
  catppuccin.setup {
    term_colors = true,
    integrations = {
      treesitter = true,
      lsp_trouble = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
      },
      which_key = true,
      markdown = true,
      ts_rainbow = true,
      hop = true,
    },
  }
  vim.cmd [[ colorscheme catppuccin ]]
end

M.github = function()
  require('github-theme').setup {
    theme_style = 'dark_default',
    function_style = 'italic',
    comment_style = 'italic',
    variable_style = 'italic',
    keyword_style = 'italic',
    hide_inactive_statusline = true,
    hide_end_of_buffer = true,
    dark_sidebar = true,
    dark_float = true,
    sidebars = { 'qf', 'terminal', 'packer', 'nvim-tree' },
    overrides = function(colors)
      return {
        htmlTag = {
          fg = colors.red,
          bg = '#282c34',
          sp = colors.hint,
          style = 'underline',
        },
        DiagnosticHint = { link = 'LspDiagnosticsDefaultHint' },
        TSField = {},
      }
    end,
  }
  vim.cmd [[ colorscheme 'github' ]]
end

M.gruvbox = function()
  vim.g.gruvbox_transparent_bg = true
  vim.cmd [[ colorscheme gruvbox ]]
end

M.highlights = function()
  vim.cmd [[
    " hi! ColorColumn guibg=#1c1a30 ctermbg=235
    hi! InlayHints guifg=#555169 ctermfg=235  
    hi! FoldColumn guifg=#575279
    hi! clear CursorLine
    hi! LineNr guifg=#1f2335
    hi! CursorLineNr guifg=#605180 gui=bold
    ]]
end

M.horizon = function()
  vim.g.horizon_transparent_bg = false
  vim.cmd [[ colorscheme horizon ]]
end

M.indentline = function()
  vim.cmd [[ hi! Indentline1 guifg=#eb6f92 ]]
  vim.cmd [[ hi! Indentline2 guifg=#f6c177 ]]
  vim.cmd [[ hi! Indentline3 guifg=#ebbcba ]]
  vim.cmd [[ hi! Indentline4 guifg=#31748f ]]
  vim.cmd [[ hi! Indentline5 guifg=#9ccfd8 ]]
  vim.cmd [[ hi! Indentline6 guifg=#c4a7e7 ]]
  -- vim.g.indent_blankline_enabled = true
  -- vim.g.indentLine_showFirstIndentLevel = 1
  -- vim.g.indentLine_setColors = 1
  -- vim.cmd "let g:indent_blankline_char_highlight_list = [\" Indentline1 \", \" Indentline2 \", \" Indentline3 \", \" Indentline4 \"]"
  -- vim.cmd "let g:indent_blankline_filetype_exclude = ['startify']"
  require('indent_blankline').setup {
    buftype_exclude = { 'terminal' },
    filetype_exclude = { 'startify', 'packer' },
    char_highlight_list = {
      'Indentline1',
      'Indentline2',
      'Indentline3',
      'Indentline4',
      'Indentline5',
      'Indentline6',
    },
    enabled = true,
    indent_level = 6,
    setColors = true,
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
  }
end

M.line_number_interval = function()
  vim.g.line_number_interval = 15
  vim.cmd 'let g:line_number_interval#custom_interval = [1,2,3,4,5,15,25,35,45,55,65]'
  vim.cmd [[
    let g:line_number_interval#use_custom = 1
    highlight DimLineNr guifg=#1f2335 gui=NONE
    highlight link HighlightedLineNr HighlightedLineNr4
    highlight HighlightedLineNr1 guifg=#4F577D
    highlight HighlightedLineNr2 guifg=#424968
    highlight HighlightedLineNr3 guifg=#353B53
    highlight HighlightedLineNr4 guifg=#2E334A
    highlight HighlightedLineNr5 guifg=#292D43
    LineNumberIntervalEnable
  ]]
end

M.material = function()
  vim.g.material_style = 'deep ocean'
  require('material').setup {
    borders = true,
    popup_menu = 'dark', -- Popup menu style ( can be: 'dark', 'light', 'colorful' or 'stealth' )
    italics = {
      comments = true,
      keywords = true,
      functions = true,
      variables = true,
    },
    contrast_windows = {
      'terminal',
      'packer',
      'qf',
      'nvim-tree',
      'lir',
      'JABS',
    },
    disable = {
      eob_lines = true,
    },
  }
  vim.cmd [[ colorscheme material ]]
end

M.moonfly = function()
  vim.g.moonflyItalics = true
  vim.g.moonflyNormalFloat = true
  vim.g.moonflyTerminalColors = true
  vim.g.moonflyTransparent = false
  vim.g.moonflyUndercurls = true
  vim.g.moonflyUnderlineMatchParen = true
  vim.g.moonflyVertSplits = true
  vim.cmd [[ colorscheme moonfly ]]
end

M.moonlight = function()
  vim.g.moonlight_italic_comments = true
  vim.g.moonlight_italic_keywords = true
  vim.g.moonlight_italic_functions = true
  vim.g.moonlight_italic_variables = false
  vim.g.moonlight_contrast = true
  vim.g.moonlight_borders = true
  vim.g.moonlight_disable_background = false
  require('moonlight').set()
end

M.nebulous = function()
  require('nebulous').setup {
    variant = 'twilight',
    disable = {
      background = true,
      endOfBuffer = false,
      terminal_colors = false,
    },
    italic = {
      comments = true,
      keywords = true,
      functions = true,
      variables = false,
    },
  }
  vim.cmd [[ colorscheme nebulous ]]
end

M.neon = function()
  vim.g.neon_transparent_bg = false
  vim.g.neon_style = 'dark'
  vim.g.neon_italic_keyword = true
  vim.g.neon_italic_function = true
  vim.g.neon_italic_variable = true
  vim.g.neon_transparent = false
  vim.g.neon_bold = true
  vim.cmd [[ colorscheme neon ]]
end

M.nightfly = function()
  vim.g.nightflyItalics = true
  vim.g.nightflyNormalFloat = true
  vim.g.nightflyTerminalColors = true
  vim.g.nightflyTransparent = false
  vim.g.nightflyUndercurls = true
  vim.g.nightflyUnderlineMatchParen = true
  vim.g.nightflyVertSplits = true
  vim.cmd [[ colorscheme nightfly ]]
end

M.nightfox = function()
  local nightfox = require 'nightfox'
  nightfox.setup {
    fox = 'nightfox',
    styles = {
      comments = 'italic',
      functions = 'italic',
      keywords = 'italic',
      strings = 'NONE',
      variables = 'NONE',
    },
    inverse = {
      match_paren = false,
      visual = false,
      search = false,
    },
  }
  nightfox.load()
end

M.rosepine = function()
  vim.g.rose_pine_variant = 'base'
  vim.g.rose_pine_enable_italics = true
  vim.g.rose_pine_disable_background = true
  vim.cmd [[ colorscheme rose-pine ]]
end

M.setup = function()
  vim.schedule(function()
    M.material()
    M.highlights()
    M.line_number_interval()
  end)
end

M.toggle_colorscheme = function()
  if vim.g.colo_num == nil then
    vim.g.colo_num = 0
  end
  local colors = vim.fn.getcompletion('', 'color')
  ---@diagnostic disable-next-line: undefined-field
  vim.g.colo_num = ((vim.g.colo_num % table.getn(colors)) + 1)
  local colorscheme = colors[vim.g.colo_num]
  vim.api.nvim_exec('colorscheme ' .. colorscheme, false)
  print(colorscheme)
end

M.tokyonight = function()
  vim.g.tokyonight_colors = { border = '#7aa2f7' }
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_day_brightness = 0.3
  vim.g.tokyonight_hide_inactive_statusline = false
  vim.g.tokyonight_italic_comments = true
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_sidebars = { 'packer' }
  vim.g.tokyonight_style = 'night'
  vim.g.tokyonight_transparent = false
  vim.cmd [[ colorscheme tokyonight ]]
end

M.vn_night = function()
  require('vn-night').setup {}
  vim.cmd [[ colorscheme vn-night ]]
end

return M
