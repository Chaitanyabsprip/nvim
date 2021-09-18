local u = require("utils")
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    buffer = {kind = "   (Buffer)"},
    emoji = {
      kind = " ﲃ  (Emoji)" -- filetypes = {"markdown", "text"}
    },
    nvim_lsp = {kind = "   (LSP)", priority = 9998},
    nvim_lua = {kind = "  "},
    path = {kind = "   (Path)"},
    snippets_nvim = {kind = "  ", priority = 9999},
    tags = false,
    treesitter = {kind = "  "},
    vim_dadbod_completion = true,
    vsnip = {kind = "   (Snippet)", priority = 10000}
  }
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

u.kmap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
u.kmap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
u.kmap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
u.kmap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- u.kmap("i", "<CR>", "compe#confirm('<CR>')",
--          {noremap = true, silent = true, expr = true})
u.kmap("i", "<A-Space>", 'compe#complete()',
       {noremap = true, silent = true, expr = true})
u.kmap("i", "<A-e>", "compe#close('<C-e>')",
       {noremap = true, silent = true, expr = true})
u.kmap("i", "<C-f>", "compe#scroll({ 'delta': +4 })",
       {noremap = true, silent = true, expr = true})
u.kmap("i", "<C-d>", "compe#scroll({ 'delta': -4 })",
       {noremap = true, silent = true, expr = true})
