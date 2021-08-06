local nvim_lsp = require('lspconfig')

nvim_lsp.html.setup {
  cmd = {
    "node",
    "/home/chaitanya/.config/nvim/lang-servers/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
    "--stdio"
  },
  filetypes = {
    'aspnetcorerazor', 'blade', 'django-html', 'edge', 'ejs', 'eruby', 'gohtml',
    'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'jade', 'leaf', 'liquid',
    'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim',
    'svelte', 'twig', 'vue'
  },
  root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
  init_options = {provideFormatter = false},
  capabilities = LSP.capabilities,
  on_attach = LSP.nf_on_attach
}
