local M = {}

function M.debounce(ms, fn)
  local timer = vim.loop.new_timer()
  return function(...)
    local argv = { ... }
    assert(timer ~= nil, 'time must not be nil')
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

function M.throttle(ms, fn)
  local timer = vim.loop.new_timer()
  local running = false
  return function(...)
    if not running then
      local argv = { ... }
      local argc = select('#', ...)
      assert(timer ~= nil, 'time must not be nil')
      timer:start(ms, 0, function()
        running = false
        pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
      end)
      running = true
    end
  end
end

local hex_to_rgb = function(hex_str)
  local hex = '[abcdef0-9][abcdef0-9]'
  local pat = '^#(' .. hex .. ')(' .. hex .. ')(' .. hex .. ')$'
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, 'hex_to_rgb: invalid hex_str: ' .. tostring(hex_str))

  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

function M.blend(fg, bg, alpha)
  bg = hex_to_rgb(bg)
  fg = hex_to_rgb(fg)

  local blendChannel = function(i)
    ---@type number
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02X%02X%02X', blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg) return M.blend(hex, bg or M.bg, math.abs(amount)) end

function M.lighten(hex, amount, fg) return M.blend(hex, fg or M.fg, math.abs(amount)) end

function M.get_visual_selection()
  ---@type integer, integer, integer, integer
  local _, strtlnum, strtcol, _ = unpack(vim.fn.getpos "'<")
  ---@type integer, integer, integer, integer
  local _, endlnum, endcol, _ = unpack(vim.fn.getpos "'>")
  local lcount = math.abs(endlnum - strtlnum) + 1
  local lines = vim.api.nvim_buf_get_lines(0, strtlnum - 1, endlnum, false)
  lines[1] = string.sub(lines[1], strtcol, -1)
  lines[lcount] = string.sub(lines[lcount], 1, endcol - (lcount == 1 and (strtcol + 1) or 0))
  return table.concat(lines, '\n')
end

function M.cowboy(disabled_ft)
  ---@type table?
  local id
  local ok = true
  for _, key in ipairs { 'h', 'j', 'k', 'l', 'w', 'b' } do
    local count = 0
    local timer = assert(vim.loop.new_timer())
    local map = key
    vim.keymap.set('n', key, function()
      if table.contains(disabled_ft, vim.bo.filetype) then return map end
      if vim.v.count > 0 then count = 0 end
      if count >= 10 then
        ok, id = pcall(vim.notify, 'धीरे भाई धीरे', vim.log.levels.WARM, {
          icon = ' 🤠',
          replace = id,
          keep = function() return count >= 10 end,
        })
        if not ok then
          id = nil
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function() count = 0 end)
        return map
      end
    end, { expr = true, silent = true })
  end
end

function M.getargs()
  ---@diagnostic disable-next-line: no-unknown
  local argv = vim.tbl_filter(function(arg)
    local nvim = arg ~= 'nvim' and arg ~= '/usr/local/bin/nvim'
    local embed = arg ~= '--embed'
    local i = arg ~= '-i'
    local none = arg ~= 'NONE'
    return embed and i and none and nvim
  end, vim.v.argv)
  return argv
end

function M.open_explorer_on_startup()
  if vim.fn.argc() < 1 or vim.fn.argc() > 1 then return end
  ---@type string
  local path = M.getargs()[1]
  local directory = vim.fn.isdirectory(path) == 1
  if not directory then return end
  vim.cmd.cd(path)
  vim.cmd 'Explorer'
end

function M.toggle_win_zoom()
  vim.opt.winminwidth = 0
  vim.opt.winminheight = 0
  return function()
    if vim.g.zoom then
      vim.cmd [[wincmd =]]
      vim.g.zoom = false
    else
      vim.cmd [[wincmd _]]
      vim.cmd [[wincmd |]]
      vim.g.zoom = true
    end
  end
end

return M
