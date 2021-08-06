vim.g.gruvbox_transparent_bg = false
vim.g.horizon_transparent_bg = false

-- Tokyonight
vim.g.tokyonight_colors = {border = "#7aa2f7", bg = "#262C3A"}
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_day_brightness = 1
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_sidebars = {'packer'}
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = false

-- Material
vim.g.material_borders = true
vim.g.material_contrast = true
vim.g.material_disable_background = false
vim.g.material_italic_comments = true
vim.g.material_italic_functions = true
vim.g.material_italic_keywords = true
vim.g.material_italic_variables = false
vim.g.material_style = 'palenight'

vim.api.nvim_set_keymap('n', '<leader>m',
                        [[:lua require('material.functions').toggle_style(true)<CR>]],
                        {noremap = true, silent = true})

-- Moonlight
vim.g.moonlight_borders = true
vim.g.moonlight_contrast = true
vim.g.moonlight_disable_background = false
vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_variables = false

-- Dracula
vim.g.dracula_colorterm = true
vim.cmd([[
augroup dracula_customization
  au!
  autocmd ColorScheme dracula hi CursorLine cterm=underline term=underline
augroup END
]])

-- Ayu
vim.g.ayucolor = "mirage"
_G.toggle_ayucolor = function()
  if vim.g.ayucolor_num == nil then
    vim.g.ayucolor_num = 0
  end
  local colors = {'mirage', 'dark', 'light'}
  ---@diagnostic disable-next-line: undefined-field
  vim.g.colo_num = ((vim.g.colo_num % table.getn(colors)) + 1)
  vim.g.ayucolor = colors[vim.g.colo_num]
  vim.api.nvim_exec("colorscheme ayu", false)
  print(vim.g.ayucolor)
end

-- require("github-theme").setup({
--   themeStyle = "dark",
--   colors = {bg = "#0d1117"},
--   functionStyle = "italic",
--   sidebars = {"packer"}
-- })
-- General
_G.toggle_colo = function()
  if vim.g.colo_num == nil then
    vim.g.colo_num = 0
  end
  local colors = vim.fn.getcompletion('', 'color')
  ---@diagnostic disable-next-line: undefined-field
  vim.g.colo_num = ((vim.g.colo_num % table.getn(colors)) + 1)
  local colorscheme = colors[vim.g.colo_num]
  vim.api.nvim_exec("colorscheme " .. colorscheme, false)
  print(colorscheme)
end
vim.api.nvim_set_keymap('n', '<leader>c', '<CMD>call v:lua.toggle_colo()<CR>',
                        {noremap = true, silent = true})
-- require'material'.set()
-- require'moonlight'.set()
vim.cmd [[colorscheme tokyonight]]
