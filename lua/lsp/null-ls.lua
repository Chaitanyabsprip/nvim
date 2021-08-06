local null_ls = require "null-ls"

null_ls.setup {
    save_after_formatting = true,
    sources = {
        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.prettier.with({
            filetypes = {"css", "html", "json", "sass", "yaml", "lua"}
        })
    },
    filetypes = {"css", "html", "json", "sass", "yaml", "lua"}
}
