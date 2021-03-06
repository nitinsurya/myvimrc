"
" Aniket's vim settings
"

filetype off
filetype plugin indent on
set nocompatible

" Use UTF-8 as the default buffer encoding
set enc=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Remember up to 100 'colon' commmands and search patterns
set history=100

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Reload files when changed on disk, i.e. via `git checkout`
set autoread

" Interface
set laststatus=2                                             " always show statusline
set showcmd
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
" set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline

" yank and paste with the system clipboard
set clipboard=unnamed

" Backups and shit
set nobackup
set nowritebackup
set noswapfile

" Text Formatting
set autoindent                                               " autoindent
set smartindent                                              " be smart about it
set shiftwidth=4                                             " normal mode indentation commands use 2 spaces
set shiftround                                               " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4                                                " actual tabs occupy 8 characters
set softtabstop=4                                            " insert mode tab and backspace use 2 spaces
set backspace=2                                              " Fix broken backspace in some setups
set expandtab                                                " expand tabs to spaces

" Searching
set hlsearch                                                 " highlight search results
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set smartcase                                                " case-sensitive search if any caps

" Tab completion
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=list:longest,full

" No sound. FTW.
set visualbell

syntax on

" Colored column (to see line size violations)
set colorcolumn=120
highlight ColorColumn ctermbg=238

set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" ---------------------------------------------------------------------------
"  " Remap the tab key to do autocompletion or indentation depending on the
"  " context
"  "
"  --------------------------------------------------------------------------
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" keyboard shortcuts
let mapleader = ','
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader>t :tabnew<Space>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

autocmd VimResized * :wincmd =

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ---------------------------------------------------------------------------
"  " Filetype specific formatting
"  "
"  --------------------------------------------------------------------------

" gitcommit
autocmd Filetype gitcommit setlocal spell textwidth=72

" markdown
autocmd Filetype markdown setlocal spell textwidth=80

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif
