#set page(paper: "us-letter", margin: 1in, numbering: "1")
#set text(font: "Courier New", size: 9pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.")

#align(center)[
  #text(size: 18pt, weight: "bold")[Neovim Configuration]
  #v(0.3em)
]

= Overview

Modular Neovim configuration optimized for performance and maintainability.

*Architecture*: `init.lua` → `config/` → `plugins/` → `lsp/`  
*Plugin Manager*: lazy.nvim | *Theme*: rosepine | *Leader*: Space

== Directory Structure

#raw(read("directory-structure.ls"))

#pagebreak()

== Design Principles
1. Lazy loading for fast startup
2. Modular, self-contained features
3. Type annotations for LSP intelligence
4. Minimal built-in plugins

#let extension-map = (
  scm: "scheme",
  vim: "vim",
  lua: "lua"
)
#let files = json("files.json")

#for path in files [
  #let ext = path.split(".").last()
  #let lang-id = extension-map.at(ext, default: ext)

  == File: #path
  #raw(read(path), lang: lang-id)
  #v(1em)
]
