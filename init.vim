" Author: Lopeztel
" Description: Lopeztel's nvim config
" Last Modified: May 07, 2022

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'arcticicestudio/nord-vim'
"https://github.com/arcticicestudio/nord-vim
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'
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
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'preservim/nerdcommenter'

"Snippets and autocompletion
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'

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

"---------------------------Startify------------------------------
"https://github.com/mhinz/vim-startify
let g:startify_custom_header= [
\ '                      _                         _       _                      ',
\ '                     | |    ___  _ __   ___ ___| |_ ___| |                     ',
\ '                     | |   / _ \| ._ \ / _ \_  / __/ _ \ |                     ',
\ '                     | |__| (_) | |_) |  __// /| ||  __/ |                     ',
\ '                     |_____\___/| .__/ \___/___|\__\___|_|                     ',
\ '                                |_|                                            ',
\ '                                                                               ',
\ ]

"------------------vim-airline settings---------------------------
"https://github.com/vim-airline/vim-airline
let g:airline_extensions_tabline_enabled = 1
let g:airline_extensions_tabline_formatter = 'unique_tail'
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
nnoremap <leader>fs <cmd>Telescope grep_string hidden=true<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ef <cmd>Telescope file_browser hidden=true<cr>

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
let g:floaterm_keymap_new = '<Leader>t'
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
lua << EOF
-- LSP servers
local servers = { "clangd", "sumneko_lua", "bashls", "cmake", "yamlls",
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
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    
  require("lsp_signature").on_attach()
  -- https://github.com/ray-x/lsp_signature.nvim
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    -- on_attach = on_attach, --without autocompletion
    capabilities = capabilities,
  }
end
EOF
