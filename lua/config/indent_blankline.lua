-- vim.g.indent_blankline_char_highlight_list = { "IndentBlanklineIndent" }

vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
  "startify",
  "dashboard",
  "dotooagenda",
  "log",
  "fugitive",
  "gitcommit",
  "packer",
  "vimwiki",
  "markdown",
  "json",
  "txt",
  "vista",
  "help",
  "todoist",
  "NvimTree",
  "peekaboo",
  "git",
  "TelescopePrompt",
  "undotree",
  "flutterToolsOutline",
  "" -- for all buffers without a file type
}
vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = false
vim.g.indent_blankline_context_patterns = {
  "class",
  "function",
  "method",
  "block",
  "list_literal",
  "selector",
  "^if",
  "^table",
  "if_statement",
  "while",
  "for"
}
-- because lazy load indent-blankline so need readd this autocmd
vim.cmd("autocmd MyAutoCmd CursorMoved * IndentBlanklineRefresh")

