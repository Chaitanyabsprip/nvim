local hashish = {}

---@alias KeymapOpts {noremap: boolean, desc:string, silent:boolean, expr: boolean, bufnr: integer, buffer: integer}

local keymap_set = vim.keymap.set

hashish.keys = {}

---@param mode string|table
---@param key string
---@param command string|function
---@param options KeymapOpts|nil
---@return nil
local register_keymap = function(mode, key, command, options)
  table.insert(hashish.keys, { mode = mode, lhs = key, rhs = command, options = options })
  return keymap_set(mode, key, command, options)
end

vim.keymap.set = register_keymap

hashish.noremap = function(mode)
  return function(key)
    return function(command)
      return function(options)
        if type(options) == 'string' then
          options = vim.tbl_extend('force', { desc = options }, { noremap = true })
          return register_keymap(mode, key, command, options)
        end
        options = vim.tbl_extend('force', options, { noremap = true })
        return hashish.map(mode)(key)(command)(options)
      end
    end
  end
end

hashish.map = function(mode)
  return function(key)
    return function(command)
      ---@param options KeymapOpts | string
      return function(options)
        if type(options) == 'string' then
          options = { desc = options }
          return register_keymap(mode, key, command, options)
        end
        return function(description)
          ---@type KeymapOpts
          options = vim.tbl_extend('force', options, { desc = description })
          options.buffer = options.bufnr
          options.bufnr = nil
          return register_keymap(mode, key, command, options)
        end
      end
    end
  end
end

hashish.nmap = function(key) return hashish.map 'n'(key) end
hashish.vmap = function(key) return hashish.map 'v'(key) end
hashish.nnoremap = function(key) return hashish.noremap 'n'(key) end
hashish.vnoremap = function(key) return hashish.noremap 'v'(key) end
hashish.tnoremap = function(key) return hashish.noremap 't'(key) end
hashish.xnoremap = function(key) return hashish.noremap 'x'(key) end
hashish.inoremap = function(key) return hashish.noremap 'i'(key) end

return hashish
