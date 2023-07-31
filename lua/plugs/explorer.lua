local explorer = {}
explorer.fuzzy = require 'plugs.fuzzy.telescope'

explorer.harpoon = {
  spec = {
    'ThePrimeagen/harpoon',
    keys = {
      {
        '<c-b>',
        function() require('harpoon.mark').add_file() end,
        noremap = true,
        desc = 'Add file to harpoon',
      },
      {
        '<c-f>',
        function() require('harpoon.ui').toggle_quick_menu() end,
        noremap = true,
        desc = 'Toggle harpoon marks list',
      },
      {
        '<c-n>',
        function() require('harpoon.ui').nav_file(1) end,
        noremap = true,
        desc = 'Jump to file 1 in harpoon',
      },
      {
        '<c-e>',
        function() require('harpoon.ui').nav_file(2) end,
        noremap = true,
        desc = 'Jump to file 2 in harpoon',
      },
      {
        '<c-o>',
        function() require('harpoon.ui').nav_file(3) end,
        noremap = true,
        desc = 'Jump to file 3 in harpoon',
      },
      {
        '<c-s>',
        function() require('harpoon.ui').nav_file(4) end,
        noremap = true,
        desc = 'Jump to file 4 in harpoon',
      },
    },
    opts = { global_settings = { mark_branch = true } },
  },
}

explorer.spec = {
  explorer.fuzzy.spec,
  explorer.harpoon.spec,
}

return explorer
