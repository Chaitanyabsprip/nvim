local nnoremap = require('utils').nnoremap

require('session-lens').setup(require('telescope.themes').get_ivy {
  layout_config = {
    height = 12,
  },
  max_height = 10,
  previewer = false,
})

require('telescope').load_extension 'session-lens'

local session_lens_map = "<CMD>lua require('session-lens').search_session()<CR>"
nnoremap('<c-s>', session_lens_map, true)
