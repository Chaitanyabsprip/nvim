---@diagnostic disable: no-unknown
local M = {}

---@alias Sign {name:string, text:string, texthl:string}
---
---@return Sign[]
local function get_signs(win)
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.tbl_map(
    ---@param sign Sign
    function(sign) return vim.fn.sign_getdefined(sign.name)[1] end,
    vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs
  )
end

M.foldcol = {
  display = function()
    local lnum = vim.v.lnum
    local icon = ''
    if vim.fn.foldlevel(lnum) <= 0 then return icon end -- Line isn't in folding range
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return icon end -- Not the first line of folding range
    icon = vim.v.virtnum == 0 and (vim.fn.foldclosed(lnum) == -1 and '' or '') or ' '
    return icon
  end,
  callback = function()
    ---@type number
    local lnum = vim.fn.getmousepos().line
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return end -- Only lines with a mark should be clickable
    local state = vim.fn.foldclosed(lnum) == -1 and 'close' or 'open'
    vim.cmd.execute("'" .. lnum .. 'fold' .. state .. "'")
  end,
}

local function numcol(win)
  if vim.v.virtnum ~= 0 then return '' end
  local wo = vim.wo[win]
  local shownum = wo.number and wo.relativenumber
  local lnum = vim.v.lnum
  local relnum = vim.v.relnum
  local nu = wo.number and lnum or ''
  local rnu = wo.relativenumber and relnum
  local num = (shownum and relnum == 0 and nu) or rnu or nu
  return num
end

local function signcol(win)
  local sign, git_sign
  for _, s in ipairs(get_signs(win)) do
    if s.name:find 'GitSign' then
      git_sign = s
    else
      sign = s
    end
  end

  local nosigncolumn = vim.wo[win].signcolumn == 'no' and ''
  sign = (sign and ('%#' .. (sign.texthl or 'DiagnosticInfo') .. '#' .. sign.text .. '%*') or '  ')
  local signcolumn = nosigncolumn or (' ' .. sign)

  local gsc = package.loaded['gitsigns.config']
  local nogitcolumn = not (gsc and gsc.config and gsc.config.signcolumn) and ''
  local gitcol = nogitcolumn
    or git_sign and ('%#' .. git_sign.texthl .. '#' .. git_sign.text .. '%*')
    or '  '

  return signcolumn, gitcol
end

local function foldcol()
  if not vim.g.foldcolumn then return '' end
  local callback = [[%@v:lua.require'config.statuscolumn'.foldcol.callback@]]
  local icon = [[%{v:lua.require'config.statuscolumn'.foldcol.display()}]]
  return ' ' .. callback .. icon .. ' '
end

function M.status_column()
  local win = vim.g.statusline_winid
  if vim.v.virtnum ~= 0 then return '' end
  local signcolumn, gitcol = signcol(win)
  local numcolumn = numcol(win)
  local foldcolumn = foldcol()
  local components = {
    signcolumn,
    numcolumn,
    [[%=]],
    foldcolumn,
    gitcol,
  }
  return table.concat(components, '')
end

return M
