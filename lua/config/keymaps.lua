---@diagnostic disable: no-unknown
local function toggle_win_zoom()
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

local function cowboy(disabled_ft)
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
                ok, id = pcall(vim.notify, 'Stop repeating chars', vim.log.levels.WARM, {
                    icon = ' 󰺛',
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

local keymaps = {}

local api = vim.api

local function buf_kill(target_buf, should_force)
    if not should_force and vim.bo.modified then
        return api.nvim_err_writeln 'Buffer is modified. Force required.'
    end
    local command = 'bd'
    if should_force then command = command .. '!' end
    if target_buf == 0 or target_buf == nil then target_buf = api.nvim_get_current_buf() end
    ---@type BufInfo[]
    local buffers = vim.fn.getbufinfo { buflisted = 1 }
    if #buffers == 1 then return api.nvim_command(command) end
    ---@type integer, integer[]
    local nextbuf, windows
    for i, buf in ipairs(buffers) do
        if buf.bufnr == target_buf then
            windows = buf.windows
            nextbuf = buffers[(i - 1 + 1) % #buffers + 1].bufnr
            break
        end
    end
    if nextbuf == nil then nextbuf = api.nvim_create_buf(true, true) end
    for _, winid in ipairs(windows) do
        api.nvim_win_set_buf(winid, nextbuf)
    end
    api.nvim_command(table.concat({ command, target_buf }, ' '))
end

keymaps.setup = function()
    local hashish = require 'hashish'
    local map = hashish.map
    local cnoremap = hashish.noremap 'c'
    local nnoremap = hashish.nnoremap
    local vnoremap = hashish.vnoremap
    local inoremap = hashish.inoremap
    local xnoremap = hashish.xnoremap

    -- Leader bindings
    nnoremap '<Space>' '<NOP>' 'Leader key'
    vim.g.mapleader = ' '

    nnoremap '<leader>q' '<cmd>q<cr>' 'Close window (:q)'
    inoremap '<c-c>' '<esc>' 'To not be annoyed by the <c-c> messages all the time'
    xnoremap '<c-c>' '<esc>' 'To not be annoyed by the <c-c> messages all the time'
    nnoremap '<leader>Q' '<cmd>qa<cr>' 'Quit all (:qa)'
    nnoremap '<leader>e' '<cmd>Explorer<cr>' 'Toggle file explorer'
    nnoremap '_' '^' 'Jump to the start of the line'
    xnoremap '_' '^' 'Jump to the start of the line'
    nnoremap '&' 'g_' 'Jump to the end of the line'
    xnoremap '&' 'g_' 'Jump to the end of the line'
    vnoremap 'J' ":m '>+1<cr>gv=gv" { silent = true } 'Move selected lines down'
    vnoremap 'K' ":m '<-2<cr>gv=gv" { silent = true } 'Move selected lines up'
    nnoremap ')' '<cmd>vertical resize +5<cr>' 'Increase current window height'
    nnoremap '(' '<cmd>vertical resize -5<cr>' 'Decrease current window height'
    nnoremap '+' '<cmd>res +1<cr>' 'Increase current window width'
    nnoremap '-' '<cmd>res -1<cr>' 'Decrease current window width'
    vnoremap '<' '<gv' 'Maintain visual selection while decreasing indent'
    vnoremap '>' '>gv' 'Maintain visual selection while increasing indent'
    vnoremap '=' '=gv' 'Maintain visual selection while auto fixing indent'
    nnoremap '<leader>y' '<cmd>%y+<cr>' 'Yank whole buffer to system clipboard'
    nnoremap '<leader>v' 'ggVG' 'Select whole buffer'
    vnoremap 'p' '"_dP' 'Paste inplace without yanking selected text'
    nnoremap '<TAB>' '<cmd>tabnext<cr>' 'To next tab'
    nnoremap '<S-TAB>' '<cmd>tabprevious<cr>' 'To previous tab'
    nnoremap 'n' 'nzzzv' 'Jump to next match and center line'
    nnoremap 'N' 'Nzzzv' 'Jump to previous match and center line'
    nnoremap 'J' 'mzJ`z' 'Join lines without moving cursor'
    nnoremap '}' '}zz' 'Like text object motion } but centers line'
    nnoremap '{' '{zz' 'Like text object motion { but centers line'
    nnoremap '<c-d>' '12jzz' 'Like text object motion <c-d> but centers line'
    nnoremap '<c-u>' '12kzz' 'Like text object motion <c-u>{ but centers line'
    vnoremap '<c-d>' '12jzz' 'Like text object motion <c-d> but centers line'
    vnoremap '<c-u>' '12kzz' 'Like text object motion <c-u>{ but centers line'
    nnoremap '<leader>r' ':%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<Left><Left><Left>' 'Search and replace, in current buffer, word under cursor'
    vnoremap '<leader>r' '"hy:%s/<C-r>h//gI<left><left><left>' 'Search and replace, in current buffer, visual selection'
    vnoremap '<leader>s' 'y:%s/<c-r>0/<c-r>0/gI<Left><Left><Left>' 'Search and modify, in current buffer, visual selection'
    nnoremap 'gn' '<cmd>cnext<cr>zz' 'Jump to next result from quickfix'
    nnoremap 'gp' '<cmd>cprev<cr>zz' 'Jump to prev result from quickfix'
    nnoremap 'gj' '<c-o>' 'Jump back the jump list'
    nnoremap 'gk' '<c-i>' 'Jump forward the jump list'
    cnoremap '<c-a>' '<Home>' 'Jump to the start of the command'
    cnoremap '<c-f>' '<c-Right>' 'Move cursor one character right'
    cnoremap '<c-b>' '<c-Left>' 'Move cursor one character left'
    cnoremap '<c-o>' '<Up>' 'Move cursor one character left'
    cnoremap '<c-i>' '<Down>' 'Move cursor one character left'
    map 's' '<NOP>' 'unmap s'
    map 'S' '<NOP>' 'unmap S'
end

function keymaps.lazy()
    local hashish = require 'hashish'
    local nnoremap = hashish.nnoremap
    local vnoremap = hashish.vnoremap
    cowboy { 'oil', 'qf', 'help', 'noice', 'lazy', 'tsplayground' }
    nnoremap 'X'(buf_kill) 'Close current buffer'
    nnoremap 'gtn'(function()
        local nu = vim.wo[api.nvim_get_current_win()].number
        return '<cmd>setlocal ' .. (nu and 'no' or '') .. 'nu<cr>'
    end) { expr = true } 'Toggle line number'
    nnoremap 'gtN'(function()
        local rnu = vim.wo[api.nvim_get_current_win()].relativenumber
        return '<cmd>setlocal ' .. (rnu and 'no' or '') .. 'rnu<cr>'
    end) { expr = true } 'Toggle relative line number'
    nnoremap '<c-w>z'(toggle_win_zoom()) 'Toggle window zoom'
    nnoremap 'gz'(toggle_win_zoom()) 'Toggle window zoom'

    local qf = require 'quickfix'
    nnoremap 'gb'(qf.buffers) 'Quickfix: List buffers'
    nnoremap 'ge' '?```<cr>jV/```<cr>k!emso<cr>:noh<cr>' 'Run shell code within markdown code snippet'
    vnoremap 'ge' 'dO```sh<esc>o```<esc>kp' 'Run visually selected shell code'
    nnoremap ',,' '<cmd>lua require("alternate").gotoAltBuffer()<cr>' 'Switch to Alternate buffer'
end

-- " " Copy to clipboard
-- vnoremap  <leader>y  "+y
-- nnoremap  <leader>Y  "+yg_
-- nnoremap  <leader>y  "+y
-- nnoremap  <leader>yy  "+yy
--
-- " " Paste from clipboard
-- nnoremap <leader>p "+p
-- nnoremap <leader>P "+P
-- vnoremap <leader>p "+p
-- vnoremap <leader>P "+P

return keymaps
