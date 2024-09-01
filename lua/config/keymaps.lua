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
local keymap = vim.keymap

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
    local utils = require 'utils'
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

    keymap.set('n', '<leader>q', '<cmd>q<cr>', {
        desc = 'Close window (:q)',
        noremap = true,
        silent = true,
    })
    keymap.set('i', '<c-c>', '<esc>', {
        desc = 'To not be annoyed by the <c-c> messages all the time',
        noremap = true,
        silent = true,
    })
    keymap.set('x', '<c-c>', '<esc>', {
        desc = 'To not be annoyed by the <c-c> messages all the time',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<leader>e', '<cmd>Explorer<cr>', {
        desc = 'Toggle file explorer',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '_', '^', {
        desc = 'Jump to the start of the line',
        noremap = true,
        silent = true,
    })
    keymap.set('x', '_', '^', {
        desc = 'Jump to the start of the line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '&', 'g_', {
        desc = 'Jump to the end of the line',
        noremap = true,
        silent = true,
    })
    keymap.set('x', '&', 'g_', {
        desc = 'Jump to the end of the line',
        noremap = true,
        silent = true,
    })
    keymap.set('v', 'J', ":m '>+1<cr>gv=gv", {
        desc = 'Move selected lines down',
        noremap = true,
        silent = true,
    })
    keymap.set('v', 'K', ":m '<-2<cr>gv=gv", {
        desc = 'Move selected lines up',
        noremap = true,
        silent = true,
    })
    keymap.set('n', ')', '<cmd>vertical resize +5<cr>', {
        desc = 'Increase current window height',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '(', '<cmd>vertical resize -5<cr>', {
        desc = 'Decrease current window height',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '+', '<cmd>res +1<cr>', {
        desc = 'Increase current window width',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '-', '<cmd>res -1<cr>', {
        desc = 'Decrease current window width',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '<', '<gv', {
        desc = 'Maintain visual selection while decreasing indent',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '>', '>gv', {
        desc = 'Maintain visual selection while increasing indent',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '=', '=gv', {
        desc = 'Maintain visual selection while auto fixing indent',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<leader>y', '<cmd>%y+<cr>', {
        desc = 'Yank whole buffer to system clipboard',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<leader>v', 'ggVG', {
        desc = 'Select whole buffer',
        noremap = true,
        silent = true,
    })
    keymap.set('v', 'p', '"_dP', {
        desc = 'Paste inplace without yanking selected text',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<TAB>', '<cmd>tabnext<cr>', {
        desc = 'To next tab',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<S-TAB>', '<cmd>tabprevious<cr>', {
        desc = 'To previous tab',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'n', 'nzzzv', {
        desc = 'Jump to next match and center line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'N', 'Nzzzv', {
        desc = 'Jump to previous match and center line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'J', 'mzJ`z', {
        desc = 'Join lines without moving cursor',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '}', '}zz', {
        desc = 'Like text object motion } but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '{', '{zz', {
        desc = 'Like text object motion { but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<c-d>', '12jzz', {
        desc = 'Like text object motion <c-d> but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<c-u>', '12kzz', {
        desc = 'Like text object motion <c-u>{ but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '<c-d>', '12jzz', {
        desc = 'Like text object motion <c-d> but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '<c-u>', '12kzz', {
        desc = 'Like text object motion <c-u>{ but centers line',
        noremap = true,
        silent = true,
    })
    keymap.set('n', '<leader>r', ':%s/\\<<c-r><c-w>\\>/<c-r><c-w>/gI<Left><Left><Left>', {
        desc = 'Search and replace, in current buffer, word under cursor',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '<leader>r', '"hy:%s/<C-r>h//gI<left><left><left>', {
        desc = 'Search and replace, in current buffer, visual selection',
        noremap = true,
        silent = true,
    })
    keymap.set('v', '<leader>s', 'y:%s/<c-r>0/<c-r>0/gI<Left><Left><Left>', {
        desc = 'Search and modify, in current buffer, visual selection',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'gn', '<cmd>cnext<cr>zz', {
        desc = 'Jump to next result from quickfix',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'gp', '<cmd>cprev<cr>zz', {
        desc = 'Jump to prev result from quickfix',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'gj', '<c-o>', {
        desc = 'Jump back the jump list',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'gk', '<c-i>', {
        desc = 'Jump forward the jump list',
        noremap = true,
        silent = true,
    })
    keymap.set('c', '<c-a>', '<Home>', {
        desc = 'Jump to the start of the command',
        noremap = true,
        silent = true,
    })
    keymap.set('c', '<c-f>', '<c-Right>', {
        desc = 'Move cursor one character right',
        noremap = true,
        silent = true,
    })
    keymap.set('c', '<c-b>', '<c-Left>', {
        desc = 'Move cursor one character left',
        noremap = true,
        silent = true,
    })
    keymap.set('c', '<c-o>', '<Up>', {
        desc = 'Move cursor one character left',
        noremap = true,
        silent = true,
    })
    keymap.set('c', '<c-i>', '<Down>', {
        desc = 'Move cursor one character left',
        noremap = true,
        silent = true,
    })
    keymap.set('n', 'gw', function()
        vim.ui.input({ prompt = '▍ ' }, vim.cmd.grep)
        vim.cmd.copen()
    end, { desc = 'Grep query and populate quickfix', noremap = true, silent = true })
    keymap.set('n', 'gW', function()
        vim.cmd.grep(utils.rg_escape(vim.fn.expand '<cword>'))
        vim.cmd.copen()
    end, { desc = 'Grep query and populate quickfix', noremap = true, silent = true })
    keymap.set('v', 'gw', function()
        local selection, _ = utils.get_visual_selection()
        vim.cmd.grep(selection)
        vim.cmd.copen()
    end, { noremap = true, silent = true })
    map 's' '<NOP>' 'unmap s'
    map 'S' '<NOP>' 'unmap S'
end

function keymaps.lazy()
    cowboy { 'oil', 'qf', 'help', 'noice', 'lazy' }
    keymap.set('n', 'X', buf_kill, { desc = 'Close current buffer', noremap = true })
    keymap.set('n', 'gtn', function()
        local nu = vim.wo[api.nvim_get_current_win()].number
        return '<cmd>setlocal ' .. (nu and 'no' or '') .. 'nu<cr>'
    end, { desc = 'Toggle line number', expr = true, noremap = true })
    keymap.set('n', 'gtN', function()
        local rnu = vim.wo[api.nvim_get_current_win()].relativenumber
        return '<cmd>setlocal ' .. (rnu and 'no' or '') .. 'rnu<cr>'
    end, { expr = true, desc = 'Toggle relative line number', noremap = true })
    keymap.set('n', '<c-w>z', toggle_win_zoom(), { desc = 'Toggle window zoom', noremap = true })
    keymap.set('n', 'gz', toggle_win_zoom(), { desc = 'Toggle window zoom', noremap = true })

    local qf = require 'quickfix'
    keymap.set('n', 'gb', qf.buffers, { desc = 'Quickfix: List buffers', noremap = true })
    keymap.set('n', 'ge', '?```<cr>jV/```<cr>k!emso<cr>:noh<cr>', {
        desc = 'Run shell code within markdown code snipper',
        noremap = true,
    })
    keymap.set('v', 'ge', 'dO```sh<esc>o```<esc>kpkw', {
        desc = 'Wrap selection in code block',
        noremap = true,
    })
    keymap.set('n', ',,', require('alternate').gotoAltBuffer, {
        desc = 'Switch to Alternate buffer',
        noremap = true,
    })

    keymap.del('n', 'grr')
    keymap.del({ 'x', 'n' }, 'gra')
    keymap.del('n', 'grn')
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
