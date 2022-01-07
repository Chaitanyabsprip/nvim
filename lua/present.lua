local M = {}

function M.kitty(enable)
  if not vim.fn.executable 'kitty' then
    return
  end
  local cmd = 'kitty @ --to %s set-font-size %s'
  local socket = vim.fn.expand '$KITTY_LISTEN_ON'
  if enable then
    vim.fn.system(cmd:format(socket, '28'))
  else
    vim.fn.system(cmd:format(socket, '12'))
  end
  vim.cmd [[redraw]]
end

function M.disable_statusline()
  vim.opt.laststatus = 1
  vim.cmd [[ echo '' ]]
end

function M.disable_ui()
  vim.opt.ruler = false
end

function M.present() end

return M
