local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local prettier_opts = {
  extra_args = {
    '--single-quote',
    '--jsx-single-quote',
    '--trailing_comma all',
    '--bracket-same-line',
    '--prose-wrap always',
  },
}

local isort_opts = {
  extra_args = {
    '--quiet',
  },
}

local flake8_opts = {
  extra_args = {
    '--max-line-length=80',
    '--ignore=W503, W504, W391',
    '--exit-zero',
    "--format='%f:%l:%c: %m'",
  },
}

local shfmt_opts = {
  extra_args = {
    '-ci',
    '-s',
    '-bn',
  },
  filetypes = {
    'sh',
    'bash',
  },
}

local shellcheck_opts = {
  extra_args = {
    '-x',
  },
  filetypes = {
    'sh',
    'bash',
  },
}

local refactoring_opts = {
  filetypes = {
    'go',
    'javascript',
    'typescript',
    'lua',
    'python',
    'c',
    'cpp',
  },
}

null_ls.setup {
  save_after_formatting = true,
  on_attach = LSP.common_on_attach,
  capabilities = LSP.capabilities,
  sources = {
    code_actions.eslint_d,
    code_actions.gitsigns,
    code_actions.refactoring.with(refactoring_opts),
    code_actions.proselint,
    diagnostics.eslint_d,
    diagnostics.flake8.with(flake8_opts),
    diagnostics.shellcheck.with(shellcheck_opts),
    diagnostics.yamllint,
    diagnostics.proselint,
    formatting.eslint_d,
    formatting.isort.with(isort_opts),
    formatting.prettier.with(prettier_opts),
    formatting.shfmt.with(shfmt_opts),
    formatting.stylua,
    formatting.yapf.with(isort_opts),
  },
}
