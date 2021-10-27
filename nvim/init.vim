"------------------ PLUGIN CONFIGURATION --------------"
"
  call plug#begin('~/.vim/plugged')
    Plug 'hrsh7th/vim-vsnip'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dracula/vim'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'tpope/vim-surround'
    Plug 'cohama/agit.vim'
    Plug 'majutsushi/tagbar'
    Plug 'morhetz/gruvbox'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'hrsh7th/nvim-compe'
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'metakirby5/codi.vim'
    Plug 'majutsushi/tagbar'
    Plug 'neoclide/coc.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'kyazdani42/nvim-web-devicons'
  call plug#end()
"------------------ PLUGIN CONFIGURATION END--------------"
lua << EOF
require('init')
EOF
"------------------ GENERAL CONFIGURATION ----------------"

 set mouse+=a
 set showcmd
 set relativenumber
 set noswapfile
 set ruler
 set incsearch
 set expandtab
 set autowriteall
 set tabstop=2
 set shiftwidth=2
 set cmdheight=2
 set nobackup
 set nowritebackup
 set updatetime=100
 set shortmess+=c
 set signcolumn=yes
 set wrap
 syntax enable
 hi Normal guibg=NONE ctermbg=NONE
 
 command! W :w
 
 noremap j gj
 noremap k gk
 
 set ignorecase
 set smartcase
 set foldmethod=indent
 set foldlevel=99
 
 :vnoremap < <gv
 :vnoremap > >gv
 nnoremap <space><space> <c-^>
 
 
 let mapleader=","
 let g:mapleaer=","
 
 "--WINDOW CONFIGURATION--"
 nmap <silent> <c-k> :wincmd k<CR>
 nmap <silent> <c-j> :wincmd j<CR>
 nmap <silent> <c-h> :wincmd h<CR>
 nmap <silent> <c-l> :wincmd l<CR>
 
 "--PUM BOx--"
 "inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
 "inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
 
 nnoremap <CR> :noh<CR><CR>
 "------------------ GENERAL CONFIGURATION END ----------------"


 "------------------ THEME CONFIGURATION START ----------------"
 colorscheme dracula
 "hi Pmenu ctermbg=
 set guicursor=
 let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
 let g:codi#virtual_text=1
 "---------------------- Telescope Config ---------------------"

 nnoremap <leader>tff <cmd>Telescope find_files<cr>
 nnoremap <leader>tlg <cmd>Telescope live_grep<cr>
 nnoremap <leader>fb <cmd>Telescope buffers<cr>
 nnoremap <leader>tgf <cmd>Telescope git_files<cr>
 nnoremap <leader>tbt <cmd>TagbarToggle<cr>
 nnoremap <leader>ee <cmd>Telescope file_browser<cr>

 "---------------------- Telescope End ---------------------"
 
 "------------------------ Native LSP ----------------------"
 

 nnoremap <silent> <C-e> :CocCommand explorer<CR>

 lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'tsserver' , 'terraformls', 'svelte' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF



"------------------------ Native LSP END ----------------------"




 "------------------------ NETRW ----------------------"

 let g:netrw_banner = 0
 let g:netrw_liststyle = 3
 let g:netrw_browse_split = 4
 let g:netrw_winsize = 20
 let g:netrw_preview=1

 "------------------------ NETRW End ----------------------"


au VimEnter * :if bufname()=='' | call execute('CocCommand explorer') | endif
let b:coc_suggest_disable = 1


