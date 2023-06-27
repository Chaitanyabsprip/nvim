local db = {}

db.dadbod = {
  spec = {
    'tpope/vim-dadbod',
    config = function() require('plugins.lsp.database').dadbod.setup() end,
  },
  setup = function() end,
}

db.dbee = {
  spec = {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
    end,
    config = function() require('dbee').setup {} end,
  },
  setup = function() end,
}

db.spec = {
  db.dbee.spec,
}

return db
