let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_shortcuts = {  "" : "", }
nmap <leader>ss <CMD>SessionSave<CR>
nmap <leader>sl <CMD>SessionLoad<CR>

let g:dashboard_custom_section = {}
let g:dashboard_custom_footer = {}

lua << EOF
vim.g.dashboard_preview_command = 'cat'
vim.g.dashboard_preview_pipeline = 'lolcat'
vim.g.dashboard_preview_file = "/Users/chaitanyasharma/.config/nvim/vimscript/plugins/neovim.cat"
vim.g.dashboard_preview_file_height = 12
vim.g.dashboard_preview_file_width = 80
EOF
