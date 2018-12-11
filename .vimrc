call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'soramugi/auto-ctags.vim'
Plug 'schickling/vim-bufonly'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'jceb/vim-orgmode'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'prettier/vim-prettier'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'iloginow/vim-stylus'
Plug 'lifepillar/vim-mucomplete'
Plug 'ember-template-lint/ember-template-lint'

call plug#end()
set nocompatible

syntax enable
let g:seoul256_background = 237
colo seoul256

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

" ===== Statusline & Linting

" Run prettier on save, async
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_sign_error = ':('
let g:ale_sign_warning = ':/'

" Always show ale column
let g:ale_sign_column_always = 1

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? ':)' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline =
set statusline +=%2*%f
set statusline +=\ %m
set statusline +=%1*\ %=
set statusline +=%{LinterStatus()}
