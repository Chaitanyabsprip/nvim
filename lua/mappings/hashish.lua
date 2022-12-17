local hashish = {}

hashish.nmap = function(key) return hashish.map 'n'(key) end

hashish.vmap = function(key) return hashish.map 'v'(key) end

hashish.nnoremap = function(key) return hashish.noremap 'n'(key) end

hashish.vnoremap = function(key) return hashish.noremap 'v'(key) end

hashish.tnoremap = function(key) return hashish.noremap 't'(key) end

hashish.xnoremap = function(key) return hashish.noremap 'x'(key) end

hashish.inoremap = function(key) return hashish.noremap 'i'(key) end

hashish.noremap = function(mode)
  return function(key)
    return function(command)
      return function(options)
        options = vim.tbl_extend('force', options, { noremap = true })
        return hashish.map(mode)(key)(command)(options)
      end
    end
  end
end

hashish.map = function(mode)
  return function(key)
    return function(command)
      return function(options)
        return function(description)
          options = vim.tbl_extend('force', options, { desc = description })
          options.buffer = options.bufnr
          options.bufnr = nil
          return vim.keymap.set(mode, key, command, options)
        end
      end
    end
  end
end

return hashish
