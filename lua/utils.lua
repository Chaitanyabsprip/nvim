local M = {}

function M.is_buffer_empty()
  -- Check whether the current buffer is empty
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end

function M.keymap(mode, key, command, opts)
  vim.api.nvim_set_keymap(mode, key, command, opts)
end

function M.buf_kmap(bufnr, mode, key, command, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
end
function M.execr(cmd)
  local fh = assert(io.popen(cmd))
  local data = fh:read('*a')
  fh:close()
  return data
end

return M
