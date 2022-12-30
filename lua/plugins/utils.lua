local utils = {}

function utils.bootstrap_packer()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      lazypath,
    }
    vim.fn.system { 'git', '-C', lazypath, 'checkout', 'tags/stable' } -- last stable release
  end
  vim.opt.runtimepath:prepend(lazypath)
end

return utils
