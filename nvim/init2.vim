"------------------ CYHTVA PBASVTHENGVBA--------------"
  call plug#begin('~/.vim/plugged')
    Plug 'andweeb/presence.nvim'
    Plug 'tpope/vim-surround'
		Plug 'scrooloose/nerdcommenter'
    Plug 'cohama/agit.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'
    Plug 'sheerun/vim-polyglot'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'metakirby5/codi.vim'
    Plug 'neoclide/coc.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'kyazdani42/nvim-web-devicons'
  call plug#end()
"------------------ PLUGIN CONFIGURATION END--------------"

"------------------ GENERAL CONFIGURATION ----------------"
set ambiwidth=double
set background=dark
filetype off
filetype plugin indent on

"--PLASE DON'T HATE ME FOR THIS"
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
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"------------------ GENERAL CONFIGURATION END ----------------"


"------------------ THEME CONFIGURATION START ----------------"
colorscheme gruvbox
let g:airline_theme = 'ubaryd'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
hi CocInfoFloat guifg=#111111 guibg=#000000
hi CocErrorFloat guifg=#111111 guibg=#000000
hi CocFloating ctermbg=red
hi Pmenu ctermbg=red

"------------------ THEME CONFIGURATION END ----------------"

"------------------ COC CONFIGURATION ----------------------"

 """au VimEnter * :if bufname()=='' | call execute('CocCommand explorer') | endif

 inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
 nmap <leader>ac  <Plug>(coc-codeaction)
 xmap <leader>f  <Plug>(coc-format-selected)
 nmap <leader>x  <Plug>(coc-fix-current)

 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)

 command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
 nmap <F2> <Plug>(coc-rename)
 :nnoremap <space>e :CocCommand explorer<CR>
 command! -nargs=0 Format :call CocAction('format')
 command! -nargs=0 PT :CocCommand prettier.formatFile
 nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
    call CocAction('doHover')
    endif
  endfunction

 "------------------ COC CONFIGURATION END ----------------------"



"------------------ FZF CONFIGURATION --------------------------"

nnoremap <silent> <C-f> :Ag<CR>
nnoremap <silent> <leader>f :Files<CR>
let g:fzf_layout = { 'down': '~40%' }

"------------------ FZF CONFIGURATION END ----------------------"
"
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:user_emmet_leader_key=','

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent> <space>c  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent> <space>x :CocCommand yank.clean<cr>


let g:codi#virtual_text=1


 "---------------------- Telescope Config ---------------------"

 nnoremap <leader>ff <cmd>Telescope find_files<cr>
 nnoremap <leader>fg <cmd>Telescope live_grep<cr>
 nnoremap <leader>fb <cmd>Telescope buffers<cr>
 nnoremap <leader>fh <cmd>Telescope help_tags<cr>
 nnoremap <leader>gf <cmd>Telescope git_files<cr>

 "---------------------- Telescope End ---------------------"
 "
 "
set guicursor=
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
let g:airline_powerline_fonts = 1
