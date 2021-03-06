local M = {}
local config = require 'config'
local prequire = require('utils').preq

M.arch = function()
  vim.cmd [[ colorscheme arch ]]
end

M.blue_moon = function()
  vim.cmd [[ colorscheme blue-moon ]]
end

M.calvera = function()
  vim.g.calvera_italic_comments = config.theme.italics.comments
  vim.g.calvera_italic_keywords = config.theme.italics.keywords
  vim.g.calvera_italic_functions = config.theme.italics.functions
  vim.g.calvera_italic_variables = config.theme.italics.variables
  vim.g.calvera_borders = true
  vim.g.calvera_contrast = true
  vim.g.calvera_hide_eob = true
  vim.g.calvera_disable_background = config.theme.transparent
  vim.g.transparent_bg = config.theme.transparent
  prequire('calvera').set()
end

M.catppuccin = function()
  local catppuccin = prequire 'catppuccin'
  catppuccin.setup {
    term_colors = true,
    transparent_background = config.theme.transparent,
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
  prequire('github-theme').setup {
    theme_style = 'dark_default',
    function_style = 'italic',
    comment_style = 'italic',
    variable_style = 'italic',
    keyword_style = 'italic',
    hide_inactive_statusline = true,
    hide_end_of_buffer = config.theme.hide_eob,
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
  vim.g.gruvbox_transparent_bg = config.theme.transparent
  vim.cmd [[ colorscheme gruvbox ]]
end

M.highlights = function()
  if vim.g.colors_name == 'rose-pine' then
    vim.cmd [[ hi! ColorColumn guibg=#1c1a30 ctermbg=235 ]]
  elseif vim.g.colors_name == 'nightfox' then
    vim.cmd [[ hi! link TelescopeNormal NvimTreeNormal ]]
  end
  vim.cmd [[ hi! CursorLineNr guifg=#605180 gui=bold ]]
  vim.cmd [[ hi! link FoldColumn Comment ]]
  vim.cmd [[ hi! link Folded Comment ]]
  -- vim.cmd [[ hi! InlayHints guifg=#555169 ctermfg=235 ]]
  vim.cmd [[ hi! LineNr guifg=#1f2335 ]]
  vim.cmd [[ hi! clear CursorLine ]]
end

M.horizon = function()
  vim.g.horizon_transparent_bg = config.theme.transparent
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
  prequire('indent_blankline').setup {
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

M.kanagawa = function()
  require('kanagawa').setup {
    undercurl = true,
    commentStyle = 'italic',
    functionStyle = 'italic',
    keywordStyle = 'italic',
    statementStyle = 'bold',
    typeStyle = 'NONE',
    variablebuiltinStyle = 'italic',
    specialReturn = true,
    specialException = true,
    transparent = config.theme.transparent,
    colors = {},
    overrides = {},
  }
  vim.cmd 'colorscheme kanagawa'
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
  prequire('material').setup {
    contrast = {
      popup_menu = true,
      sidebars = true,
      floating_windows = true,
      cursor_line = true,
    },
    italics = {
      comments = true,
      keywords = true,
      functions = true,
      variables = true,
    },
    contrast_filetypes = config.theme.sidebars,
    disable = {
      eob_lines = config.theme.hide_eob,
      background = config.theme.transparent,
    },
  }
  vim.cmd [[ colorscheme material ]]
end

M.moonfly = function()
  vim.g.moonflyItalics = true
  vim.g.moonflyNormalFloat = true
  vim.g.moonflyTerminalColors = true
  vim.g.moonflyTransparent = config.theme.transparent
  vim.g.moonflyUndercurls = true
  vim.g.moonflyUnderlineMatchParen = true
  vim.g.moonflyVertSplits = true
  vim.cmd [[ colorscheme moonfly ]]
end

M.moonlight = function()
  vim.g.moonlight_italic_comments = config.theme.italics.comments
  vim.g.moonlight_italic_keywords = config.theme.italics.keywords
  vim.g.moonlight_italic_functions = config.theme.italics.functions
  vim.g.moonlight_italic_variables = config.theme.italics.variables
  vim.g.moonlight_disable_background = config.theme.transparent
  vim.g.moonlight_contrast = true
  vim.g.moonlight_borders = true
  prequire('moonlight').set()
end

M.nebulous = function()
  prequire('nebulous').setup {
    variant = 'night',
    disable = {
      background = config.theme.transparent,
      endOfBuffer = true,
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
  vim.g.neon_style = 'dark'
  vim.g.neon_italic_keyword = true
  vim.g.neon_italic_function = true
  vim.g.neon_italic_variable = true
  vim.g.neon_transparent = config.theme.transparent
  vim.g.neon_bold = true
  vim.cmd [[ colorscheme neon ]]
end

M.nightfly = function()
  vim.g.nightflyItalics = true
  vim.g.nightflyNormalFloat = true
  vim.g.nightflyTerminalColors = true
  vim.g.nightflyTransparent = config.theme.transparent
  vim.g.nightflyUndercurls = true
  vim.g.nightflyUnderlineMatchParen = true
  vim.g.nightflyVertSplits = true
  vim.cmd [[ colorscheme nightfly ]]
end

M.nightfox = function()
  local nightfox = prequire 'nightfox'
  nightfox.setup {
    fox = 'nightfox',
    transparent = config.theme.transparent,
    styles = {
      comments = 'italic',
      functions = 'italic',
      keywords = 'italic',
      strings = 'NONE',
      variables = 'NONE',
    },
    hlgroups = {
      TelescopeBorder = {
        fg = '${fg_gutter}',
        bg = '${bg_sidebar}',
      },
      TelescopePreviewBorder = {
        fg = '${fg_gutter}',
        bg = '${bg_sidebar}',
      },
      TelescopeResultsBorder = {
        fg = '${fg_gutter}',
        bg = '${bg_sidebar}',
      },
      TelescopePromptBorder = {
        fg = '${fg_gutter}',
        bg = '${bg_sidebar}',
      },
    },
  }
  nightfox.load()
end

M.rosepine = function()
  vim.g.rose_pine_variant = 'base'
  vim.g.rose_pine_enable_italics = true
  vim.g.rose_pine_disable_background = config.theme.transparent
  vim.cmd [[ colorscheme rose-pine ]]
end

M.sakura = function()
  local sakura = prequire 'sakura'
  sakura.setup {
    variant = 'moon',
    transparent = config.theme.transparent,
    italics = true,
  }
  sakura.load()
end

M.setup = function()
  vim.schedule(function()
    M.catppuccin()
    M.highlights()
    M.line_number_interval()
    prequire('statusline').lualine()
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
  vim.notify(colorscheme)
end

M.tokyonight = function()
  vim.g.tokyonight_colors = { border = '#7aa2f7' }
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_day_brightness = 0.3
  vim.g.tokyonight_hide_inactive_statusline = false
  vim.g.tokyonight_italic_comments = config.theme.italics.comments
  vim.g.tokyonight_italic_functions = config.theme.italics.functions
  vim.g.tokyonight_italic_keywords = config.theme.italics.keywords
  vim.g.tokyonight_italic_variables = config.theme.italics.variables
  vim.g.tokyonight_sidebars = { 'packer' }
  vim.g.tokyonight_style = 'night'
  vim.g.tokyonight_transparent = config.theme.transparent
  vim.cmd [[ colorscheme tokyonight ]]
end

M.vn_night = function()
  prequire('vn-night').setup {}
  vim.cmd [[ colorscheme vn-night ]]
end

return M
