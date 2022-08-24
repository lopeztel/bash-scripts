" Author: Lopeztel
" Description: Lopeztel's nvim config
" Last Modified: May 10, 2022

call plug#begin('~/.vim/plugged')

"Optimization
Plug 'lewis6991/impatient.nvim'

" Appearance and dashboard
Plug 'arcticicestudio/nord-vim'
"https://github.com/arcticicestudio/nord-vim
Plug 'vim-airline/vim-airline'
Plug 'goolord/alpha-nvim' 
Plug 'folke/persistence.nvim'
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-web-devicons'
"https://github.com/kyazdani42/nvim-web-devicons

"Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'voldikss/vim-floaterm'

" IDE features
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'p00f/clangd_extensions.nvim'
Plug 'rhysd/vim-clang-format'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'preservim/nerdcommenter'
Plug 'windwp/nvim-autopairs'

" debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'rcarriga/cmp-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

"Snippets and autocompletion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'

"Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()

"-----------------------Common-----------------------------------
"Encoding
set encoding=utf-8

" Set colorscheme
colorscheme nord

" select with mouse
set mouse=a

"set column and line
set cursorline cursorcolumn

" set line numbers 
set number

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Map the leader key to SPACE
let mapleader="\<SPACE>"

"-----------------------Tabs--------------------------------------
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smarttab

"-----------------------Window Movement---------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"----------------------Tab Movement-------------------------------
nnoremap <C-t> <cmd>tabnew<cr>
nnoremap <C-Left> <cmd>tabpre<cr>
nnoremap <C-Right> <cmd>tabnext<cr>

"------------------------Splits-----------------------------------
nnoremap <S-Right> <cmd>vsplit<cr>
nnoremap <S-Down> <cmd>split<cr>

"---------------------------Impatient-----------------------------
"https://github.com/lewis6991/impatient.nvim

lua require("impatient")

"---------------------------Dashboard-----------------------------
"https://github.com/goolord/alpha-nvim
"https://github.com/folke/persistence.nvim

lua << EOF

-- saving previous session
require("persistence").setup{
    event = "BufReadPre", --only start session saving when an actual file was opened
}

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
-- Set header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "p", "  > Restore previous session"   , ":lua require('persistence').load({ last = true })<CR>"),
    dashboard.button( "s", "  > Settings" , ":e ~/.config/nvim/init.vim<CR>"),
    dashboard.button( "u", "  > Update Plugins" , ":PlugUpdate<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}

-- quote
table.insert(dashboard.config.layout, { type = "padding", val = 1 })
table.insert(dashboard.config.layout, {
  type = "text",
  quote = require "alpha.fortune"(),
  val = "\t\t\tNAVIGATION:\n\n<C-t>    Open a new tab\n<C-Left>    Go to previous tab\n<C-Right>    Go to next tab\n<S-Right>    Split right\n<S-Down>    Split below\n<C-h>    Move to the window left\n<C-j>    Move to the window below\n<C-k>    Move to the window above\n<C-l>    Move to the window right",
  opts = {
    position = "center",
    hl = "AlphaQuote",
  },
})

-- footer
local function footer()
  local v = vim.version()
  local datetime = os.date " %d-%m-%Y   %H:%M:%S"
  local platform = vim.fn.has "win32" == 1 and "" or ""
  return string.format("  v%d.%d.%d %s  %s", v.major, v.minor, v.patch, platform, datetime)
end

dashboard.section.footer.val = footer()
-- Send config to alpha
alpha.setup(dashboard.opts)

-- hide tabline and statusline on startup screen
vim.api.nvim_create_augroup("alpha_tabline", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  command = "set showtabline=0 laststatus=0 noruler",
})

vim.api.nvim_create_autocmd("FileType", {
  group = "alpha_tabline",
  pattern = "alpha",
  callback = function()
    vim.api.nvim_create_autocmd("BufUnload", {
      group = "alpha_tabline",
      buffer = 0,
      command = "set showtabline=2 ruler laststatus=3",
    })
  end,
})
-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
EOF
"-----------------Alternative header for dashboard----------------
" dashboard.section.header.val= {
"  "                      _                         _       _                      ",
"  "                     | |    ___  _ __   ___ ___| |_ ___| |                     ",
"  "                     | |   / _ \| ._ \ / _ \_  / __/ _ \ |                     ",
"  "                     | |__| (_) | |_) |  __// /| ||  __/ |                     ",
"  "                     |_____\___/| .__/ \___/___|\__\___|_|                     ",
"  "                                |_|                                            ",
"  "                                                                               ",
"  }

"-------------------------which-key-------------------------------
"https://github.com/folke/which-key.nvim

lua << EOF
local wk = require("which-key")

wk.register({
  f = {
        name = "Find operations", -- file group name
        f = { "files" },
        g = { "string" },
        b = { "in buffers" },
        h = { "in help tags" },
        s = { "in workspace symbols" },
        o = { "in recent files" },
      },
--  d = { "show diagnostics (hover)" },
--  q = { "show diagnostics (list)" },
  t = {
        name = "Terminal",
        n = { "new" },
        t = { "toggle" },
        h = { "prev" },
        l = { "next" },
      },
  ["/"] = { "Toggle comment" },
  c = {
      name = "comments and clang-format",
      t = { "Toggle auto format" },
      f = { "format selection" },
      },
  e = { "open file explorer" },
  w = {
        name = "Workspace",
        a = { "add folder" },
        r = { "remove folder" },
        l = { "list folders" },
      },
  }, { prefix = "<leader>" })

wk.register({
  a = { "code actions" },
  s = { "go to type definition" },
  R = { "rename symbol under cursor" },
  D = { "go to declaration" },
  d = { "go to definition" },
  I = { "go to implementation" },
  r = { "go to references" },
  }, { prefix = 'g' })

wk.setup {}
EOF

"------------------vim-airline settings---------------------------
"https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
" let g:Powerline_symbols = 'fancy'

"--------------Special characters and Indentline------------------
"https://github.com/lukas-reineke/indent-blankline.nvim
set list
" set listchars=eol:↴,tab:»·,trail:~,space:·
set listchars=eol:↴,tab:»·,trail:~

let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_show_end_of_line = 1
" let g:indent_blankline_show_current_context = 1
" let g:indent_blankline_show_current_context_start = 1

" --------------Telescope internal settings-----------------------
"https://github.com/nvim-telescope/telescope-file-browser.nvim
"https://github.com/nvim-telescope/telescope-fzf-native.nvim
"
lua << EOF
require("telescope").load_extension "file_browser"
EOF

" ----------------------Telescope---------------------------------
"https://github.com/nvim-telescope/telescope.nvim
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep hidden=true<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles hidden=true<cr>
" nnoremap <leader>fs <cmd>Telescope grep_string hidden=true<cr>
nnoremap <leader>fs <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>e <cmd>Telescope file_browser hidden=true<cr>

"needs fd and ripgrep

" Telescope commands:
" Ctrl-v -> open in vertical split
" Ctrl-x -> open in horizontal split

" ----------------------Nerd Commenter----------------------------
"https://github.com/preservim/nerdcommenter
" " Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" " Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

vmap <Leader>/ <plug>NERDCommenterToggle
nmap <Leader>/ <plug>NERDCommenterToggle

"-----------------------Floaterm----------------------------------
"https://github.com/voldikss/vim-floaterm
let g:floaterm_keymap_new = '<Leader>tn'
let g:floaterm_keymap_prev = '<Leader>th'
let g:floaterm_keymap_next = '<Leader>tl'
let g:floaterm_keymap_toggle = '<Leader>tt'

"----------------------Treesitter---------------------------------
"https://github.com/nvim-treesitter/nvim-treesitter
lua << EOF
require("nvim-treesitter.configs").setup{
  -- A list of parser names, or "all"
  ensure_installed = { "cpp", "lua", "bash", "c", "cmake", "yaml", "python",
  "make", "markdown", "latex" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
--     disable = { "c", "rust" }, -- disable highlight for
  },
  indent = {
    enable = true,
  },
}

-- Folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
EOF

" Folding commands:
" zo -> open fold
" zc -> close fold
" zO -> open fold recursively
" zC -> close fold recursively

"----------------------LSP----------------------------------------
"https://github.com/williamboman/nvim-lsp-installer/
"https://github.com/neovim/nvim-lspconfig
"https://github.com/p00f/clangd_extensions.nvim
lua << EOF
-- LSP servers
local servers = { "clangd", "sumneko_lua", "bashls", "cmake", "yamlls",
    "pyright", "prosemd_lsp", "ltex", "lemminx", "vimls"}
local servers_no_clangd = { "sumneko_lua", "bashls", "cmake", "yamlls",
    "pyright", "prosemd_lsp", "ltex", "lemminx", "vimls"}
require("nvim-lsp-installer").setup({
    ensure_installed = servers, -- ensure these servers are always installed
    -- "svls" doesn't work
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Completion
-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
  snippet = {
    expand = function(args)
    vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sorting = {
    comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("clangd_extensions.cmp_scores"),
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {noremap=true, silent=true}
-- vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    
  require("lsp_signature").on_attach()
  -- https://github.com/ray-x/lsp_signature.nvim
end

-- Add additional capabilities supported by nvim-cmp
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, lsp in pairs(servers_no_clangd) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    -- capabilities = capabilities,
  }
end

-- clangd_extensions
require("clangd_extensions").setup{
  server = {
       on_attach = on_attach,
--     capabilities = capabilities,
  },
}

EOF

"-------------------------Autopairs-------------------------------
"https://github.com/windwp/nvim-autopairs
lua << EOF
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
EOF

"-----------------------clang-format------------------------------
"https://github.com/rhysd/vim-clang-format
let g:clang_format#command='clang-format-11'
let g:clang_format#detect_style_file=1
let g:clang_format#code_style='llvm'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "c++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

" map to <Leader>f in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>ct :ClangFormatAutoToggle<CR>

"-----------------------Markdown----------------------------------
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" nnoremap <M-m> :MarkdownPreview<CR>
nnoremap <M-t> :MarkdownPreviewToggle<CR>

"-----------------------DAP Debugging------------------------
"https://github.com/mfussenegger/nvim-dap

lua << EOF
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'step_over()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>dp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl_open())<CR>")

local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/opt/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

local dap = require('dap')
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    externalConsole = "true",
    additionalSOLibSearchPath = "/opt/systemc-2.3.2/lib-linux64",
    args = {"-L", "1"},
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp

dap.defaults.fallback.terminal_win_cmd = '20split new'

-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
vim.keymap.set('n', '<leader>ds', ':Telescope dap frames<CR>')
vim.keymap.set('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

require('nvim-dap-virtual-text').setup()

-- require("dapui").setup()
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("cmp").setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches" }, {
  sources = {
    { name = "dap" },
  },
})

EOF
