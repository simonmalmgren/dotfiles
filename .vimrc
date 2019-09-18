call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'schickling/vim-bufonly'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'jceb/vim-orgmode'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'mustache/vim-mustache-handlebars'
Plug 'iloginow/vim-stylus'
Plug 'ember-template-lint/ember-template-lint'
Plug 'digitaltoad/vim-pug'
" snippetz
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
set nocompatible

syntax enable
colo base16-ia-light
syntax on

filetype plugin indent on

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=a                     "Allow the use of mouse in terminal
set clipboard=unnamed           "Use clipboard on terminal

set hidden
syntax on

" ===== Search

set incsearch
set nohlsearch
" set hlsearch

" ===== Swap Files

set noswapfile
set nobackup
set nowb

" ===== Indentation

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ===== AUTOcompleteion

set completeopt+=menuone
set completeopt+=noselect

" ==== Comments
autocmd FileType stylus setlocal commentstring=//\ %s

" ==== ctags
" let g:auto_ctags = 1

" ===== SNIPPETZ
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ===== MISC

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" Always show status bar
set laststatus=2

" Move between buffers
map gn :bn<cr>
map gp :bp<cr>

" Frequent mispellings
command! W w
command! Wqall wqall
command! WQall wqall
command! Q q
command! Qall qall

" Indent with tab
nmap <TAB> >>

" FZF
nmap <leader>f :FZF<CR>
nmap <leader>b :Buffers<CR>

" Toggle quickfix and location list
let g:toggle_list_no_mappings = 1

" Close things
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>k :call ToggleQuickfixList()<CR>
nmap <script> <silent> <leader>q :bdel<CR>

" Add dash to keywords for certain filetypes
au Filetype css,html set iskeyword+=-

" Allow JSX syntax in non .jsx files
let g:vim_jsx_pretty_colorful_config = 1

" ===== Folds

set nofoldenable

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline =
set statusline+=%#warningmsg#
set statusline+=%*

set statusline +=%2*%f
set statusline +=\ %m
set statusline +=%1*\ %=
set statusline  +=%{SyntasticStatuslineFlag()}
