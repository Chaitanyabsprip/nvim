local utils = {}
utils.ntst = { noremap = true, silent = true }
utils.nt = { noremap = true }
utils.st = { silent = true }

-- Check whether the current buffer is empty
function utils.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand '%:t') == 1
end

-- Check if the windows width is greater than a given number of columns
function utils.has_width_gt(cols)
  return vim.fn.winwidth(0) / 2 > cols
end

function utils.map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode or '', key, cmd, opts)
end

function utils.nnoremap(key, cmd, silent)
  vim.api.nvim_set_keymap('n', key, cmd, { noremap = true, silent = silent })
end

function utils.inoremap(key, cmd)
  vim.api.nvim_set_keymap('i', key, cmd, { noremap = true })
end

function utils.vnoremap(key, cmd)
  vim.api.nvim_set_keymap('v', key, cmd, { noremap = true })
end

function utils.xnoremap(key, cmd)
  vim.api.nvim_set_keymap('x', key, cmd, { noremap = true })
end

function utils.tnoremap(key, cmd)
  vim.api.nvim_set_keymap('t', key, cmd, { noremap = true })
end

function utils.onoremap(key, cmd, silent)
  vim.api.nvim_set_keymap('o', key, cmd, { noremap = true, silent = silent })
end

function utils.bmap(bufnr, mode, key, command, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
end

function utils.execr(cmd)
  local fh = assert(io.popen(cmd))
  local data = fh:read '*a'
  fh:close()
  return data
end

-- write a function to convert a table to its string representation as a table
function utils.table_to_string(tbl)
  local str = '{'
  for k, v in pairs(tbl) do
    if type(v) == 'table' then
      v = utils.table_to_string(v)
    end
    str = str .. tostring(k) .. '=' .. tostring(v) .. ','
  end
  str = str .. '}'
  return str
end

return utils
