vim.api.nvim_create_autocmd('BufWrite', {
    group = vim.api.nvim_create_augroup('alacritty', { clear = true }),
    pattern = vim.env.HOME .. '/.config/alacritty/*/*.toml',
    command = '!touch ~/.config/alacritty/alacritty.toml',
})
