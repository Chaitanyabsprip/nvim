local u = require("utils")
local ntst = {noremap = true, silent = true}
local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require'nvim-tree'.setup {
  auto_close = true,
  diagnostics = {
    enable = true,
    icons = {hint = "", info = "", warning = "", error = ""}
  },
  disable_netrw = true,
  hijack_cursor = true,
  hijack_netrw = true,
  ignore_ft_on_setup = {},
  open_on_setup = false,
  open_on_tab = true,
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {}
  },
  update_cwd = false,
  update_focused_file = {enable = false, update_cwd = false, ignore_list = {}}, -- configuration options for the system open command (`s` in the tree by default)
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 50,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'right',
    -- if true the tree will resize itself after opening a file
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {
        {key = {"<CR>", "<2-LeftMouse>", "l"}, cb = tree_cb("edit")},
        {key = {"<2-RightMouse>", "<C-]>", "cd"}, cb = tree_cb("cd")},
        {key = {"<C-v>", "v"}, cb = tree_cb("vsplit")},
        {key = {"<C-x>", "s"}, cb = tree_cb("split")},
        {key = {"<BS>", "h", "<S-CR>"}, cb = tree_cb("close_node")},
        {key = {"o"}, cb = tree_cb("system_open")}
      }
    }
  }
}

-- vim.g.nvim_tree_bindings = {
--   {key = {"<CR>", "o", "<2-LeftMouse>", "l"}, cb = tree_cb("edit")},
--   {key = {"<2-RightMouse>", "<C-]>", "cd"}, cb = tree_cb("cd")},
--   {key = {"<C-v>", "v"}, cb = tree_cb("vsplit")},
--   {key = {"<C-x>", "s"}, cb = tree_cb("split")},
--   {key = {"<BS>", "h", "<S-CR>"}, cb = tree_cb("close_node")},
--   -- {key = "<C-t>", cb = tree_cb("tabnew")},
--   -- {key = "<", cb = tree_cb("prev_sibling")},
--   -- {key = ">", cb = tree_cb("next_sibling")},
--   -- {key = "P", cb = tree_cb("parent_node")},
--   -- {key = "<S-CR>", cb = tree_cb("close_node")},
--   -- {key = "<Tab>", cb = tree_cb("preview")},
--   -- {key = "K", cb = tree_cb("first_sibling")},
--   -- {key = "J", cb = tree_cb("last_sibling")},
--   -- {key = "I", cb = tree_cb("toggle_ignored")},
--   -- {key = "H", cb = tree_cb("toggle_dotfiles")},
--   -- {key = "R", cb = tree_cb("refresh")}, -- this is to format
--   -- {key = "a", cb = tree_cb("create")}, -- this is to format
--   -- {key = "d", cb = tree_cb("remove")}, -- this is to format
--   -- {key = "r", cb = tree_cb("rename")},
--   -- {key = "<C-r>", cb = tree_cb("full_rename")},
--   -- {key = "x", cb = tree_cb("cut")}, -- this is to format
--   -- {key = "c", cb = tree_cb("copy")}, -- this is to format
--   -- {key = "p", cb = tree_cb("paste")}, -- this is to format
--   -- {key = "y", cb = tree_cb("copy_name")},
--   -- {key = "Y", cb = tree_cb("copy_path")},
--   -- {key = "gy", cb = tree_cb("copy_absolute_path")},
--   -- {key = "[c", cb = tree_cb("prev_git_item")},
--   -- {key = "]c", cb = tree_cb("next_git_item")},
--   -- {key = "-", cb = tree_cb("dir_up")}, -- this is to format
--   -- {key = "q", cb = tree_cb("close")},
--   {key = "g?", cb = tree_cb("toggle_help")}
-- }

vim.g.nvim_add_trailing = 1
vim.g.nvim_tree_auto_ignore_ft = 'startify'
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_indent_markers = 0
vim.cmd [[ let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } ]]

u.kmap('n', '<S-r>', ':NvimTreeRefresh<CR>', ntst)
u.kmap('n', '<leader>e', ':NvimTreeToggle<CR>', ntst)
u.kmap('n', '<leader>nf', '<CMD>NvimTreeFindFile<CR>', ntst)

