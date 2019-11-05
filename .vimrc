call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'schickling/vim-bufonly'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'heavenshell/vim-prettier'
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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
set nocompatible

syntax enable
colo base16-ia-light
syntax on

filetype plugin indent on

set number
set backspace=indent,eol,start "Allow backspace in insert mode
set history=1000
set showcmd "Show incomplete cmds down the bottom
set showmode "Show current mode down the bottom
set visualbell "No sounds
set autoread "Reload files changed outside vim
set mouse=a "Allow the use of mouse in terminal
set clipboard=unnamed "Use clipboard on terminal

set hidden
syntax on

set list listchars=tab:\ \ ,trail:· "Display tabs and trailing spaces visually

set nowrap "Don't wrap lines
set linebreak   "Wrap lines at convenient points
set laststatus=2 "Always show status bar

command! W w
command! Wqall wqall
command! WQall wqall
command! Q q
command! Qall qall

nmap <TAB> >>

set incsearch
set nohlsearch
" set hlsearch

set noswapfile
set nobackup
set nowb
set nofoldenable

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set completeopt+=menuone
set completeopt+=noselect

autocmd FileType stylus setlocal commentstring=//\ %s

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

nmap <leader>f :FZF<CR>
nmap <leader>b :Buffers<CR>

let g:toggle_list_no_mappings = 1

nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>k :call ToggleQuickfixList()<CR>
nmap <script> <silent> <leader>q :bdel<CR>

au Filetype css,html set iskeyword+=-

let g:vim_jsx_pretty_colorful_config = 1 "Allow JSX syntax in non .jsx files

nmap <script> <silent> <leader>t :UndotreeToggle<cr>

if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

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
set statusline +=%{SyntasticStatuslineFlag()}
