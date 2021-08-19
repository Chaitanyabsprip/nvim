local ntst = {noremap = true, silent = true}
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
  {key = {"<CR>", "o", "<2-LeftMouse>", "l"}, cb = tree_cb("edit")},
  {key = {"<2-RightMouse>", "<C-]>", "cd"}, cb = tree_cb("cd")},
  {key = {"<C-v>", "v"}, cb = tree_cb("vsplit")},
  {key = {"<C-x>", "s"}, cb = tree_cb("split")},
  -- {key = "<C-t>", cb = tree_cb("tabnew")},
  -- {key = "<", cb = tree_cb("prev_sibling")},
  -- {key = ">", cb = tree_cb("next_sibling")},
  -- {key = "P", cb = tree_cb("parent_node")},
  {key = {"<BS>", "h", "<S-CR>"}, cb = tree_cb("close_node")},
  -- {key = "<S-CR>", cb = tree_cb("close_node")},
  -- {key = "<Tab>", cb = tree_cb("preview")},
  -- {key = "K", cb = tree_cb("first_sibling")},
  -- {key = "J", cb = tree_cb("last_sibling")},
  -- {key = "I", cb = tree_cb("toggle_ignored")},
  -- {key = "H", cb = tree_cb("toggle_dotfiles")},
  -- {key = "R", cb = tree_cb("refresh")}, -- this is to format
  -- {key = "a", cb = tree_cb("create")}, -- this is to format
  -- {key = "d", cb = tree_cb("remove")}, -- this is to format
  -- {key = "r", cb = tree_cb("rename")},
  -- {key = "<C-r>", cb = tree_cb("full_rename")},
  -- {key = "x", cb = tree_cb("cut")}, -- this is to format
  -- {key = "c", cb = tree_cb("copy")}, -- this is to format
  -- {key = "p", cb = tree_cb("paste")}, -- this is to format
  -- {key = "y", cb = tree_cb("copy_name")},
  -- {key = "Y", cb = tree_cb("copy_path")},
  -- {key = "gy", cb = tree_cb("copy_absolute_path")},
  -- {key = "[c", cb = tree_cb("prev_git_item")},
  -- {key = "]c", cb = tree_cb("next_git_item")},
  -- {key = "-", cb = tree_cb("dir_up")}, -- this is to format
  -- {key = "q", cb = tree_cb("close")},
  {key = "g?", cb = tree_cb("toggle_help")}
}

vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_side = 'right'
vim.g.nvim_tree_width = 50
vim.g.nvim_tree_auto_ignore_ft = 'startify'
vim.g.nvim_tree_follow = 0
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_add_trailing = 1
vim.g.nvim_tree_hijack_cursor = 0

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', ntst)
vim.api.nvim_set_keymap('n', '<S-r>', ':NvimTreeRefresh<CR>', ntst)
