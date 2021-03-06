
lua << EOF
  local nvim_lsp = require 'lspconfig'

  local root_pattern = function(...)
    local old_f = lsp.util.root_pattern(...)
    return function(startpath)
      local work_dir = old_f(startpath) or vim.fn.fnamemodify(filepath, ':h')
      vim.api.nvim_command('cd ' .. work_dir)
      return work_dir
    end
  end

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guifg=green guibg=DarkGray
        hi LspReferenceText cterm=bold ctermbg=red guifg=green guibg=DarkGray
        hi LspReferenceWrite cterm=bold ctermbg=red guifg=green guibg=DarkGray
        augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
    end

    vim.api.nvim_err_writeln(string.format("lsp(%s) started.", client.name))
  end

  -- Use a loop to conveniently both setup defined servers 
  -- and map buffer local keybindings when the language server attaches
  local servers = {
    "pyright",
    "rust_analyzer",
    "cmake",
    -- "clangd",
    "gopls",
    "cssls",
    "tsserver" }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
  end

  -- c/c++
  nvim_lsp.clangd.setup {
    cmd = {"clangd", "--background-index", "--fallback-style=webkit"};
    -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F4>', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
      on_attach(client, bufnr)
    end
  }

EOF
