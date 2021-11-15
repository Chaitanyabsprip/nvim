vim.g.gruvbox_transparent_bg = false
vim.g.horizon_transparent_bg = false

vim.g.tokyonight_colors = {border = "#7aa2f7", bg = "#262C3A"}
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_day_brightness = 0.3
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_sidebars = {'packer'}
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_transparent = false

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
vim.cmd [[ colo rose-pine ]]
-- vim.cmd [[ colo blue-moon ]]
-- vim.cmd [[ colo tokyonight ]]
-- vim.cmd [[ colo github ]]
