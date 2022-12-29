local utils = {}

function utils.bootstrap_packer()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--single-branch',
      '--branch=stable',
      'https://github.com/folke/lazy.nvim.git',
      lazypath,
    }
  end
  vim.opt.runtimepath:prepend(lazypath)
end

return utils
