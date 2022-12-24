local completion = {}

function completion.get_capabilities()
  local cmp_lsp = require 'cmp_nvim_lsp'
  local capabilities = require('lsp').capabilities()
  return cmp_lsp.default_capabilities(capabilities)
end

completion.luasnip = {
  spec = {
    'L3MON4D3/LuaSnip',
    version = '1.*',
    config = function() require('plugins.lsp.completion').luasnip.setup() end,
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
  },
  setup = function()
    local luasnip = require 'luasnip'
    local types = require 'luasnip.util.types'
    luasnip.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = { active = { virt_text = { { '●', 'Error' } } } },
        [types.insertNode] = {
          active = { virt_text = { { '●', 'Comment' } } },
        },
      },
    }
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}

completion.cmp = {}

function completion.cmp.setup()
  local cmp = require 'cmp'
  local types = require 'cmp.types'
  local select_item_opts = { behavior = types.cmp.SelectBehavior.Select }
  local luasnip = require 'luasnip'
  local lspkind = require 'lspkind'

  local function has_words_before()
    ---@diagnostic disable-next-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end

  cmp.setup {
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(select_item_opts), { 'i', 'c' }),
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(select_item_opts), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<CR>'] = cmp.mapping.confirm { select = true },
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    },
    formatting = { format = lspkind.cmp_format { mode = 'symbol_text' } },
    experimental = { ghost_text = true },
  }

  cmp.setup.cmdline('/', {
    mapping = cmp.config.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.config.mapping.preset.cmdline(),
    sources = cmp.config.sources {
      { name = 'path' },
      { name = 'cmdline' },
      { name = 'nvim_lsp' },
    },
  })
end

completion.cmp.spec = {
  'hrsh7th/nvim-cmp',
  config = function() require('plugins.lsp.completion').cmp.setup() end,
  event = 'InsertEnter',
  dependencies = {
    completion.luasnip.spec,
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
  },
}

completion.spec = {
  completion.cmp.spec,
  { 'Alexisvt/flutter-snippets', ft = { 'dart' } },
  { 'Nash0x7E2/awesome-flutter-snippets', ft = { 'dart' } },
  { 'natebosch/dartlang-snippets', ft = 'dart' },
}

return completion
