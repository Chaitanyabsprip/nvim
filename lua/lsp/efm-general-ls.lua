local nvim_lsp = require "lspconfig"

local python_arguments = {}
local isort = {formatCommand = "isort --quiet -", formatStdin = true}
local yapf = {formatCommand = "yapf --quiet", formatStdin = true}
local black = {formatCommand = "black --quiet -", formatStdin = true}
local flake8 = { -- !TODO: replace with path argument
  LintCommand = "flake8 --ignore=W503,W504,W391 --exit-zero --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"}
}
local mypy = { -- !TODO: replace with path argument NOT WORKING
  LintCommand = "mypy --show-column-numbers",
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
  }
}

-- table.insert(python_arguments, mypy)
table.insert(python_arguments, isort)
table.insert(python_arguments, flake8)

-- table.insert(python_arguments, black)
table.insert(python_arguments, yapf)

local lua_arguments = {}
local luaFormat = {
  formatCommand = "lua-format -i --indent-width=2 --no-keep-simple-function-one-line --no-keep-simple-control-block-one-line",
  formatStdin = true
}
table.insert(lua_arguments, luaFormat)

local sh_arguments = {}
local shfmt = {formatCommand = "shfmt -ci -s -bn", formatStdin = true}
local shellcheck = {
  LintCommand = "shellcheck -f gcc -x",
  lintFormats = {
    "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"
  }
}
table.insert(sh_arguments, shfmt)
table.insert(sh_arguments, shellcheck)

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local tsserver_args = {}
table.insert(tsserver_args, prettier)
table.insert(tsserver_args, eslint)

nvim_lsp.efm.setup {
  on_attach = function()
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {update_in_insert = true})
  end,
  init_options = {documentFormatting = true},
  filetypes = {
    "css", "fish", "html", "javascript", "javascriptreact", "json", "lua",
    "python", "scss", "sh", "typescript", "typescriptreact", "vue", "yaml",
    "zsh"
  },
  -- filetypes = {
  --   "fish", "javascript", "javascriptreact", "python", "sh", "typescript",
  --   "typescriptreact", "vue", "zsh"
  -- },
  settings = {
    rootMarkers = {".git/", ".gitignore"},
    languages = {
      css = {prettier},
      html = {prettier},
      javascript = tsserver_args,
      javascriptreact = tsserver_args,
      json = {prettier},
      lua = lua_arguments,
      python = python_arguments,
      sass = {prettier},
      scss = {prettier},
      sh = sh_arguments,
      typescript = tsserver_args,
      typescriptreact = tsserver_args,
      yaml = {prettier}
    }

  }
}
