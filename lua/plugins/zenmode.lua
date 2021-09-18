require("zen-mode").setup {
  plugins = {kitty = {enabled = true, font = "+4"}},
  ---@diagnostic disable-next-line: unused-local
  on_open = function(win)
    print("ZEN MODE")
  end,
  on_close = function()
    print("NORMAL MODE")
  end
}
