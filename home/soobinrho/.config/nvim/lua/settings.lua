---
-- Basic Settings
---
-- Taken from:
-- https://github.com/arnvald/viml-to-lua/blob/main/lua/settings.lua
require('impatient') -- enable plugins cache files for faster loading
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
HOME = os.getenv("HOME")
vim.o.encoding = "utf-8"
vim.o.history = 1000
vim.o.timeout = false
vim.o.ttimeout = true
vim.o.ttimeoutlen = 100
vim.o.showbreak= '↪' -- character to show when line is broken

-- More convinient key mappings
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true})

-- Display
vim.o.termguicolors = true
vim.o.showmatch  = true -- show matching brackets
vim.o.scrolloff = 8 -- always show 8 rows from edge of the screen
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2 -- always show status line
vim.g.material_style = "oceanic"
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.cmd 'colorscheme material'
vim.cmd 'hi Normal guibg=NONE'

-- Sidebar
vim.o.number = true -- line number on the left
vim.o.numberwidth = 3 -- always reserve 3 spaces for line number
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 0
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//'   -- swap files

-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command

-- Only show cursorline in the current window and in normal mode
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

-- Press <F5> to compile and run
vim.cmd([[
  map <F5> :call CompileRunGcc()<CR>
  func! CompileRunGcc()
    exec "w"
    if &filetype == 'python'
        exec "Start! -wait=always time python %"
    elseif &filetype == 'c'
        exec "Start! -wait=always gcc % -o %< && time ./%<"
    elseif &filetype == 'cpp'
        exec "Start! -wait=always g++ ./%:r*.cpp -o ./_%:r && time ./_%:r && rm ./_%:r"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    elseif &filetype == 'markdown'
        exec "Start! -wait=always glow %"
    elseif &filetype == 'sh'
        exec "Start! -wait=always time bash %"
    elseif &filetype == 'java'
        exec "Start! -wait=always javac % && time java -cp %:p:h %:t:r"
    elseif &filetype == 'go'
        exec "Start! -wait-always go build %< && time go run %"
    endif
  endfunc
]])

-- Compile init.lua everytime it's modified
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])


---
-- Plugins initialization
---
require("nvim-tree").setup()
require("nvim_comment").setup()
require("colorizer").setup()
require("indent_blankline").setup({
  show_first_indent_level = false,
  use_treesitter = true,
  show_current_context = false
})

---
-- Lualine configs
---
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 4, -- 4: Shows buffer name + buffer number
      }
    }
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {'nvim-tree'}
}

---
-- LSP configs
---
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "angularls", "awk_ls", "bashls",
    "clangd", "cmake", "cssls",
    "dockerls", "gopls", "html",
    "jsonls", "ltex", "phpactor",
    "powershell_es", "pyright", "yamlls",
    "rust_analyzer", "sqlls", "tsserver",
    "volar", "lemminx"
  },
  automatic_installation = true;
})

---
-- nvim-cmp and lunasnip configs
---
-- from:
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
require('luasnip.loaders.from_vscode').lazy_load()
local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 3},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = true}),

    ['<C-d>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

---
-- Treesitter configs
---
require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers),
  -- or a list of languages
  ensure_installed = { "python", "java", "cpp",
                       "javascript", "comment", "bash",
                       "bibtex", "c", "c_sharp",
                       "cmake", "css", "dockerfile",
                       "dot", "gitattributes", "go",
                       "help", "hjson", "html",
                       "jsdoc", "json", "json5",
                       "jsonc", "julia", "kotlin",
                       "latex", "lua", "make",
                       "markdown", "php", "r",
                       "regex", "rst", "scss",
                       "scheme", "sql", "toml",
                       "typescript", "yaml"},
  auto_install = true,
  highlight = { enable = true }
}

---
-- LSP servers initialization
---


-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'LspAttached',
--   group = group,
--   desc = 'LSP actions',
--   callback = function()
--     local bufmap = function(mode, lhs, rhs)
--       local opts = {buffer = true}
--       vim.keymap.set(mode, lhs, rhs, opts)
--     end
--
--     -- You can search each function in the help page.
--     -- For example :help vim.lsp.buf.hover()
--
--     bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
--     bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
--     bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
--     bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
--     bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
--     bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
--     bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
--     bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
--     bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
--     bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
--     bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
--     bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
--     bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
--   end
-- })
--



-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end


require'lspconfig'.angularls.setup{}
require'lspconfig'.awk_ls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.ltex.setup{}
require'lspconfig'.phpactor.setup{}
require'lspconfig'.powershell_es.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.sqlls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.volar.setup{}
require'lspconfig'.lemminx.setup{}
