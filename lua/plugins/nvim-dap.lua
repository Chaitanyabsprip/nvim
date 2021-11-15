local u = require('utils')
local ntst = {noremap = true, silent = true}
require('telescope').load_extension('dap')

u.kmap("n", "<leader>dcm",
       "<CMD>lua require'telescope'.extensions.dap.commands{}<CR>", ntst)
u.kmap("n", "<leader>dcf",
       "<CMD>lua require'telescope'.extensions.dap.configurations{}<CR>", ntst)
u.kmap("n", "<leader>dlb",
       "<CMD>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", ntst)
u.kmap("n", "<leader>dv",
       "<CMD>lua require'telescope'.extensions.dap.variables{}<CR>", ntst)
u.kmap("n", "<leader>df",
       "<CMD>lua require'telescope'.extensions.dap.frames{}<CR>", ntst)
u.kmap("n", "<leader>dt", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", ntst)
u.kmap("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", ntst)
u.kmap("n", "<leader>dso", "<CMD>lua require'dap'.step_over()<CR>", ntst)
u.kmap("n", "<leader>dsi", "<CMD>lua require'dap'.step_into()<CR>", ntst)
u.kmap("n", "<leader>dro", "<CMD>lua require'dap'.repl_open()<CR>", ntst)

require("dapui").setup({
  icons = {expanded = "▾", collapsed = "▸"},
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>", "<2-LeftMouse>"},
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r"
  },
  sidebar = {
    -- open_on_start = true,
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25 -- Can be float or integer > 1
      }, {id = "breakpoints", size = 0.25}, {id = "stacks", size = 0.25},
      {id = "watches", size = 00.25}
    },
    size = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    -- open_on_start = true,
    elements = {"repl"},
    size = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {close = {"q", "<Esc>"}}
  },
  windows = {indent = 1}
})
