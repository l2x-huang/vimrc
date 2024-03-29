
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_git_gl = 1
vim.g.nvim_tree_gitignore = 0
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_auto_close = 1
-- vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
}

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- redefine mappings
vim.g.nvim_tree_disable_default_keybindings = 1
-- default mappings
vim.g.nvim_tree_bindings = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
  { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
  { key = "v",                            cb = tree_cb("vsplit") },
  { key = "<C-t>",                        cb = tree_cb("tabnew") },
  { key = "<",                            cb = tree_cb("prev_sibling") },
  { key = ">",                            cb = tree_cb("next_sibling") },
  { key = "P",                            cb = tree_cb("parent_node") },
  { key = "<BS>",                         cb = tree_cb("close_node") },
  { key = "<S-CR>",                       cb = tree_cb("close_node") },
  { key = "<Tab>",                        cb = ':wincmd w<CR>' },
  { key = "K",                            cb = tree_cb("first_sibling") },
  { key = "J",                            cb = tree_cb("last_sibling") },
  { key = "I",                            cb = tree_cb("toggle_ignored") },
  { key = "H",                            cb = tree_cb("toggle_dotfiles") },
  { key = "R",                            cb = tree_cb("refresh") },
  { key = "a",                            cb = tree_cb("create") },
  { key = "d",                            cb = tree_cb("remove") },
  { key = "r",                            cb = tree_cb("rename") },
  { key = "<C-r>",                        cb = tree_cb("full_rename") },
  { key = "x",                            cb = tree_cb("cut") },
  { key = "c",                            cb = tree_cb("copy") },
  { key = "p",                            cb = tree_cb("paste") },
  { key = "y",                            cb = tree_cb("copy_name") },
  { key = "Y",                            cb = tree_cb("copy_path") },
  { key = "[c",                           cb = tree_cb("prev_git_item") },
  { key = "]c",                           cb = tree_cb("next_git_item") },
  { key = "-",                            cb = tree_cb("dir_up") },
  { key = "q",                            cb = tree_cb("close") },
  { key = "?",                           cb = tree_cb("toggle_help") },
}

-- https://github.com/kyazdani42/nvim-tree.lua/issues/292#issuecomment-893010829
require('nvim-tree.view').View.winopts.signcolumn = 'no'
require('nvim-tree.view').View.width = 27
