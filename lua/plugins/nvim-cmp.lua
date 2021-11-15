local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
                 :match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                        mode, true)
end

local cmp = require 'cmp'
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, {"i", "s"}),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<A-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
    ['<CR>'] = cmp.mapping.confirm({select = true})
  },
  sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'vsnip'}}, {
    {name = 'nvim_lua'}, {name = 'nvim_lsp_document_symbol'}
  }, {{name = 'path'}, {name = 'emoji'}}, {{name = 'cmdline_history'}},
                               {{name = 'buffer'}, {name = 'rg'}}),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[Snippet]",
        path = "[PATH]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]"
      })
    })
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset, cmp.config.compare.exact,
      cmp.config.compare.score, require"cmp-under-comparator".under,
      cmp.config.compare.kind, cmp.config.compare.sort_text,
      cmp.config.compare.length, cmp.config.compare.order
    }
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

vim.cmd [[ imap <silent><script><expr> <C-L> copilot#Accept() ]]
vim.g.copilot_no_tab_map = true
