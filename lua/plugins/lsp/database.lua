local db = {}

db.dadbod = { spec = { 'tpope/vim-dadbod', event = 'VeryLazy' } }

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
    opts = {},
  },
  setup = function() end,
}

db.spec = {
  db.dbee.spec,
}

return db.spec
