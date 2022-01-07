require('notify').setup {
  background_colour = '#555689',
}

---Send a notification
-- @param msg of the notification to show to the user
-- @param level Optional log level
-- @param opts Dictionary with optional options (timeout, etc)
vim.notify = function(msg, level, opts)
  local l = vim.log.levels
  assert(type(msg) == 'string', 'msg should be a string')
  assert(
    type(level) ~= 'table',
    'level should be one of vim.log.levels or a string'
  )
  opts = opts or {}
  level = level or l.INFO
  local levels = {
    [l.DEBUG] = 'Debug',
    [l.INFO] = 'Information',
    [l.WARN] = 'Warning',
    [l.ERROR] = 'Error',
  }
  opts.title = opts.title or type(level) == 'string' and level or levels[level]
  opts.timeout = 300
  local notify = require 'notify'
  notify(msg, level, opts)
end
