" Easy enough neovim config for people

" Plugins via Vim-Plug
call plug#begin()
if has('nvim')
    " Go-to-definition, references, completion, etc support
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'

    " Wilder (bottom menu)
    Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Buffer (tab-like) switcher (not vim-tabs)
Plug 'ap/vim-buftabline'

" Cool Vim theme
Plug 'liuchengxu/space-vim-dark'

call plug#end()

" Wilder turn on
call wilder#setup({'modes': [':', '/', '?']})

" Vim general config
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number
set title
set mouse=a

set completeopt=menu,menuone,noselect
" set completeopt=menuone,noinsert,noselect
set shortmess+=c

syntax on
set signcolumn=number
color space-vim-dark 
" Make bg transparent
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

" -- Shortcuts
" tab switch
nnoremap <C-N>      :bnext<CR>
nnoremap <C-Right>  :bnext<CR>
nnoremap <C-Left>   :bprev<CR>
" Fzf
nnoremap <C-P>      :FZF<CR>
" Grep (find in folder)
nnoremap <C-F>      :Rg<CR>
" cmp setup
nnoremap <C-F>      :Rg<CR>


" LSP Stuff
lua << EOF
-- Setup cmp
local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      -- Tab autocomplete
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      -- For vsnip user.
      { name = 'vsnip' },
      { name = 'buffer' },
    }
  })

-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
end

-- Add new servers (languages) support here:
local servers = { 'rls', 'clangd', 'pylsp' }
require'lspconfig'.rls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.pylsp.setup{}

EOF
