local snap = require 'snap'

snap.register.map({"n"}, {"<leader>fg"}, function()
  snap.run {
    producer = snap.get 'consumer.limit'(100000,
                                         snap.get 'producer.ripgrep.vimgrep'),
    select = snap.get'select.vimgrep'.select,
    multiselect = snap.get'select.vimgrep'.multiselect,
    views = {snap.get 'preview.vimgrep'}
  }
end)

snap.register.map({"n"}, {"<leader><leader>"}, function()
  snap.run {
    producer = snap.get 'consumer.fzf'(snap.get 'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get 'preview.file'}
  }
end)

snap.register.map({"n"}, {"<leader>fb"}, function()
  snap.run {
    producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.buffer'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get 'preview.file'}
  }
end)

snap.register.map({"n"}, {"<leader>fo"}, function()
  snap.run {
    producer = snap.get 'consumer.fzf'(snap.get 'producer.vim.oldfile'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get 'preview.file'}
  }
end)
