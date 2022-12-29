local snap = {}

snap.spec = {
  'camspiers/snap',
  keys = {
    '<leader><leader>',
    '<leader>fg',
    '<leader>fb',
    '<leader>fo',
    '<leader>fn',
  },
  config = function() require('plugins.fuzzy.snap').setup() end,
}

snap.setup = function()
  local s = require 'snap'
  s.register.map(
    { 'n' },
    { '<leader>fg' },
    function()
      s.run {
        producer = s.get 'consumer.limit'(10000, s.get 'producer.ripgrep.vimgrep'),
        select = s.get('select.vimgrep').select,
        multiselect = s.get('select.vimgrep').multiselect,
        views = { s.get 'preview.vimgrep' },
      }
    end
  )
  s.register.map(
    { 'n' },
    { '<leader><leader>' },
    function()
      s.run {
        producer = s.get 'consumer.fzf'(s.get 'producer.ripgrep.file'),
        select = s.get('select.file').select,
        multiselect = s.get('select.file').multiselect,
        views = { s.get 'preview.file' },
      }
    end
  )
  s.register.map(
    { 'n' },
    { '<leader>fb' },
    function()
      s.run {
        producer = s.get 'consumer.fzf'(s.get 'producer.vim.buffer'),
        select = s.get('select.file').select,
        multiselect = s.get('select.file').multiselect,
        views = { s.get 'preview.file' },
      }
    end
  )
  s.register.map(
    { 'n' },
    { '<leader>fo' },
    function()
      s.run {
        producer = s.get 'consumer.fzf'(s.get 'producer.vim.oldfile'),
        select = s.get('select.file').select,
        multiselect = s.get('select.file').multiselect,
        views = { s.get 'preview.file' },
      }
    end
  )
  s.register.map(
    { 'n' },
    { '<leader>fn' },
    function()
      s.run {
        producer = s.get 'consumer.fzf'(
          s.get('producer.ripgrep.file').args({}, vim.fn.expand '$HOME' .. '/Projects/Notes')
        ),
        select = s.get('select.file').select,
        multiselect = s.get('select.file').multiselect,
        views = { s.get 'preview.file' },
      }
    end
  )
end

return snap
