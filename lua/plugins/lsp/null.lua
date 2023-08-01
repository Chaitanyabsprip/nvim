local null_ft = { 'lua', 'fish', 'yaml', 'markdown', 'md', 'rmd', 'rst', 'python' }
return {
    'jose-elias-alvarez/null-ls.nvim',
    ft = null_ft,
    opts = function()
      local get_capabilities = require('plugins.lsp.completion').get_capabilities
      local builtins = require('null-ls').builtins
      local code_actions = builtins.code_actions
      local hover = builtins.hover
      local formatting = builtins.formatting
      local diagnostics = builtins.diagnostics
      local refactoring_opts = {
        filetypes = { 'go', 'javascript', 'typescript', 'lua', 'python', 'c', 'cpp' },
      }
      return {
        save_after_formatting = true,
        on_attach = require('lsp').on_attach,
        capabilities = get_capabilities(),
        sources = {
          code_actions.gitsigns,
          code_actions.refactoring.with(refactoring_opts),
          diagnostics.markdownlint,
          diagnostics.codespell.with { filetypes = { 'markdown' } },
          diagnostics.yamllint,
          formatting.beautysh,
          formatting.black.with { extra_args = { '--quiet', '-l', '80' } },
          formatting.deno_fmt.with {
            filetypes = { 'markdown' },
            extra_args = { '--prose-wrap="preserve"' },
          },
          formatting.fish_indent,
          formatting.isort.with { extra_args = { '--quiet' } },
          formatting.markdownlint,
          formatting.stylua,
          formatting.shfmt,
          hover.dictionary,
        },
      }
    end,
}

