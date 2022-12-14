local utils = {}

function utils.bootstrap_packer()
  local execute = vim.api.nvim_command
  local fn = vim.fn
  local install_path1 = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  local install_path2 = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
  local is_headless = #vim.api.nvim_list_uis() == 0

  if fn.empty(fn.glob(install_path1)) > 0 and fn.empty(fn.glob(install_path2)) > 0 then
    print 'installing packer'
    fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path1,
    }
    print 'packer installed'
    execute 'packadd packer.nvim'
    return true, is_headless
  end
  return false, is_headless
end

return utils
