local kind_icons = {
  Text = '',
  Method = 'm',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match '%s'
      == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(key, true, true, true),
    mode,
    true
  )
end

local cmp = require 'cmp'
local types = require 'cmp.types'
local select_item_opts = { behavior = types.cmp.SelectBehavior.Select }

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(
      cmp.mapping.select_next_item(select_item_opts),
      { 'i', 'c' }
    ),
    ['<C-k>'] = cmp.mapping(
      cmp.mapping.select_prev_item(select_item_opts),
      { 'i', 'c' }
    ),
    ['<A-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'emoji' },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format(
        '%s %s',
        kind_icons[vim_item.kind],
        vim_item.kind
      )
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[LUA]',
        vsnip = '[Snippet]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },
  experimental = {
    ghost_text = true,
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources {
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'nvim_lua' },
  },
})

vim.cmd [[ imap <silent><script><expr> <C-L> copilot#Accept("") ]]
vim.g.copilot_no_tab_map = true
