-- use "dstein64/vim-startuptime"
-- use {
--   "f-person/git-blame.nvim",
--   config = function()
--     vim.g.gitblame_enabled = false
--   end
-- }
-- use {
--   'glacambre/firenvim',
--   run = function()
--     vim.fn['firenvim#install'](0)
--   end
-- }
-- use "haringsrob/nvim_context_vt"
-- use "jubnzv/virtual-types.nvim"
-- use "kevinhwang91/nvim-bqf"
-- use "jose-elias-alvarez/null-ls.nvim"
-- use {
--   "kevinhwang91/rnvimr",
--   config = function()
--     vim.cmd [[
--     tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
--     nnoremap <silent> <M-o> :RnvimrToggle<CR>
--     tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
--   ]] --   end,
--   cmd = {'RnvimrToggle'}
-- }
-- use "lilyinstarlight/vim-sonic-pi"
-- use "mattn/emmet-vim"
-- use 'matbme/JABS.nvim'
-- use "metakirby5/codi.vim"
-- use "natebosch/dartlang-snippets"
-- use "nvim-telescope/telescope-media-files.nvim"
-- use {
--   "rmagatti/goto-preview",
--   config = function()
--     require('goto-preview').setup {
--       width = 120, -- Width of the floating window
--       height = 15, -- Height of the floating window
--       default_mappings = true, -- Bind default mappings
--       debug = false, -- Print debug information
--       opacity = nil -- 0-100 opacity level of the floating window where 100 is fully transparent.
--     }
--   end
-- }
-- use "sbdchd/neoformat"
-- use {
--   "simrat39/symbols-outline.nvim",
--   config = function()
--     vim.g.symbols_outline = {
--       highlight_hovered_item = true,
--       show_guides = true,
--       auto_preview = false, -- experimental
--       position = 'right',
--       keymaps = {
--         close = "q",
--         goto_location = "<Cr>",
--         focus_location = "o",
--         hover_symbol = "<C-space>",
--         rename_symbol = "r",
--         code_actions = "a"
--       },
--       lsp_blacklist = {}
--     }
--     vim.api.nvim_set_keymap("n", "<M-s>", ":SymbolsOutline<CR>",
--                             {noremap = true, silent = true})
--   end,
--   cmd = {'SymbolsOutline'}
-- }
-- use "tpope/vim-repeat"
-- use "vimwiki/vimwiki"
-- use "voldikss/vim-floaterm"
-- use { "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install --frozen-lockfile && yarn compile" }
--[[ use {
    "phaazon/hop.nvim",
    as = "hop",
    config = function()
      require"hop".setup {keys = "etovxqpdygfblzhckisuran"}
      vim.api.nvim_set_keymap('n', 'gw',
                              "<cmd>lua require'hop'.hint_words()<cr>", {})
      vim.api.nvim_set_keymap('n', 'gp',
                              "<cmd>lua require'hop'.hint_patterns()<cr>", {})
      vim.api.nvim_set_keymap('n', 'gl',
                              "<cmd>lua require'hop'.hint_lines()<cr>", {})
      vim.api.nvim_set_keymap('n', 'g1',
                              "<cmd>lua require'hop'.hint_char1()<cr>", {})
      vim.api.nvim_set_keymap('n', 'g2',
                              "<cmd>lua require'hop'.hint_char2()<cr>", {})
    end
  } ]] -- use {"rcarriga/vim-ultest", requires = {"janko/vim-test"}, run = ":UpdateRemotePlugins" }
-- use "Dave-Elec/gruvbox"
-- use "christianchiarulli/nvcode-color-schemes.vim"
-- use "ntk148v/vim-horizon"
-- use {"dracula/vim", as = "dracula"}
-- use {
--   'tzachar/compe-tabnine',
--   run = './install.sh',
--   requires = 'hrsh7th/nvim-compe'
-- }
-- use {"glepnir/galaxyline.nvim", branch = "main"}
