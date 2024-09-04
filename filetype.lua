vim.filetype.add {
    extension = {
        conf = 'conf',
        env = 'dotenv',
        rasi = 'rasi',
    },
    filename = {
        ['.env'] = 'dotenv',
        ['tsconfig.json'] = 'jsonc',
        ['.yamlfmt'] = 'yaml',
        ['launch.json'] = 'jsonc',
        Appfile = 'ruby',
        Brewfile = 'ruby',
        Fastfile = 'ruby',
        Gemfile = 'ruby',
        Pluginfile = 'ruby',
        Podfile = 'ruby',
    },
    pattern = {
        ['%.env%.[%w_.-]+'] = 'dotenv',
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/git/config'] = 'git_config',
        ['.*/kitty/*.conf'] = 'kitty',
        ['.*/hypr/.*%.conf'] = 'hyprlang',
        ['.*/dockerfiles/.*'] = 'dockerfile',
        ['.*%.conf'] = 'conf',
        ['.*%.theme'] = 'conf',
        ['.*%.gradle'] = 'groovy',
        ['^.env%..*'] = 'bash',
    },
}
