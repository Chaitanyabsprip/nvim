local completion = {}

---@class LazyPluginSpec
completion.luasnip = {
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  version = '2.*',
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
    },
  },
  opts = function()
    local types = require 'luasnip.util.types'
    return {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = { active = { virt_text = { { '●', 'Error' } } } },
        [types.insertNode] = { active = { virt_text = { { '●', 'Comment' } } } },
      },
    }
  end,
}

---@class LazyPluginSpec
completion.cmp = {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'BufReadPre' },
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'onsails/lspkind.nvim',
  },
  opts = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
    end

    local cmdline_map_presets = cmp.config.mapping.preset.cmdline()
    local search_opts = { mapping = cmdline_map_presets, sources = { { name = 'buffer' } } }
    local cmdline_opt = {
      mapping = cmdline_map_presets,
      sources = cmp.config.sources { { name = 'path' }, { name = 'cmdline' }, { name = 'nvim_lsp' } },
    }

    cmp.setup.cmdline('/', search_opts)
    cmp.setup.cmdline(':', cmdline_opt)

    return {
      snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
      sources = cmp.config.sources(
        { { name = 'luasnip' }, { name = 'nvim_lsp' }, { name = 'path' } },
        { { name = 'buffer' } }
      ),
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        },
      },
      experimental = { ghost_text = { hl_group = 'Comment' } },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local fmt = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            menu = {
              buffer = 'Buffer',
              nvim_lsp = 'LSP',
              luasnip = 'LuaSnip',
              nvim_lua = 'Lua',
              latex_symbols = 'Latex',
              path = 'Path',
            },
          }(entry, vim_item)
          local strings = vim.split(fmt.kind, '%s', { trimempty = true })
          fmt.kind = ' ' .. (strings[1] or '') .. ' '
          fmt.menu = '\t\t(' .. (fmt.menu or '') .. ')'
          return fmt
        end,
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
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ['<CR>'] = cmp.mapping.confirm { select = true },
      },
    }
  end,
}

completion.spec = {
  completion.luasnip,
  completion.cmp,
  { 'Alexisvt/flutter-snippets', ft = { 'dart' } },
  { 'Nash0x7E2/awesome-flutter-snippets', ft = { 'dart' } },
  { 'natebosch/dartlang-snippets', ft = 'dart' },
}

function completion.spec.get_capabilities()
  local cmp_lsp = require 'cmp_nvim_lsp'
  local capabilities = require('lsp').capabilities()
  local cmp_capabilities = cmp_lsp.default_capabilities()
  return vim.tbl_deep_extend('force', capabilities, cmp_capabilities)
end

return completion.spec
