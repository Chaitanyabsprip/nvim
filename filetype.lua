if not vim.filetype then return end

vim.filetype.add {
  extension = {},
  filename = {
    ['NEOGIT_COMMIT_EDITMSG'] = 'NeogitCommitMessage',
    ['.psqlrc'] = 'conf',
    ['launch.json'] = 'jsonc',
    Appfile = 'ruby',
    Brewfile = 'ruby',
    Fastfile = 'ruby',
    Gemfile = 'ruby',
    Pluginfile = 'ruby',
    Podfile = 'ruby',
  },
  pattern = {
    ['.*%.conf'] = 'conf',
    ['.*%.theme'] = 'conf',
    ['.*%.gradle'] = 'groovy',
    ['^.env%..*'] = 'bash',
  },
}
