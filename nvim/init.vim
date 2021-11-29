"=============================================
"           PLUGIN CONFIGURATION
"=============================================
"
  call plug#begin('~/.vim/plugged')
    Plug 'w0rp/ale'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'github/copilot.vim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'sheerun/vim-polyglot'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dracula/vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'metakirby5/codi.vim'
    Plug 'majutsushi/tagbar'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'neoclide/coc.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'kyazdani42/nvim-web-devicons'
  call plug#end()

"=============================================
"         GENERAL CONFIGURATION
"=============================================

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
 set scrolloff=5
 hi Normal guibg=NONE ctermbg=NONE
 
 command! W :w
:command Q q
 
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
 let g:mapleader=","
 
 nmap <silent> <c-k> :wincmd k<CR>
 nmap <silent> <c-j> :wincmd j<CR>
 nmap <silent> <c-h> :wincmd h<CR>
 nmap <silent> <c-l> :wincmd l<CR>
 
 
 nnoremap <CR> :noh<CR><CR>


 "=============================================
 "            THEME CONFIGURATION
 "=============================================
 colorscheme dracula
 "hi Pmenu ctermbg=
 set background=dark
 set guicursor=
 let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
 let g:codi#virtual_text=1

 "=============================================
 "            TELESCOPE MAPPINGS
 "=============================================

 nnoremap <leader>ff <cmd>Telescope find_files<cr>
 nnoremap <leader>lg <cmd>Telescope live_grep<cr>
 nnoremap <leader>fb <cmd>Telescope buffers<cr>
 nnoremap <leader>tgf <cmd>Telescope git_files<cr>
 nnoremap <leader>tbt <cmd>TagbarToggle<cr>


 "=============================================
 "            COC CONFIGURATION
 "=============================================
 

 nnoremap <silent> <C-e> :CocCommand explorer<CR>
 let b:coc_suggest_disable = 1


  "=============================================
  "             MAGIC ZOOM BOOM
  "=============================================

  function! s:ZoomToggle() abort
      if exists('t:zoomed') && t:zoomed
          execute t:zoom_winrestcmd
          let t:zoomed = 0
      else
          let t:zoom_winrestcmd = winrestcmd()
          resize
          vertical resize
          let t:zoomed = 1
      endif
  endfunction
  command! ZoomToggle call s:ZoomToggle()
  nnoremap <silent> <leader>z :ZoomToggle<CR>


"=====================================
"      ALLOW GLOBAL COPY PASTE
"=====================================

vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


"=====================================
"       COPILOT CONFIGURATION
"=====================================

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


"=========================================
"           ALE CONFIGURATION
"=========================================

let g:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1


nmap <leader>ac  :ALECodeAction<CR>
vmap <leader>ac  :ALECodeAction<CR>

nmap <leader>af  :ALEFix<CR>
vmap <leader>af  :ALEFix<CR>

nmap <silent> gd :ALEGoToDefinition<CR>
nmap <silent> gr :ALEFindReferences<CR>
nmap <silent> <space>rn :ALERename<CR>
