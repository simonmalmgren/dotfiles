call plug#begin('~/.vim/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'w0rp/ale'
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
Plug 'ap/vim-buftabline'
Plug 'easymotion/vim-easymotion'
Plug 'prettier/vim-prettier'

call plug#end()
set nocompatible

syntax enable
colo seoul256-light

filetype plugin indent on

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=a                     "Allow the use of mouse in terminal
set clipboard=unnamed           "Use clipboard on terminal

set hidden
syntax on

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

" Launch FZF with CTRL P
nmap <c-p> :FZF<CR>

" Toggle quickfix and location list
let g:toggle_list_no_mappings = 1

nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>k :call ToggleQuickfixList()<CR>
nmap <script> <silent> <leader>q :bdel<CR>

" Add dash to keywords for certain filetypes
au Filetype css,less,html,htmldjango set iskeyword+=-

" Allow JSX syntax in non .jsx files
" let g:jsx_ext_required = 0
let g:vim_jsx_pretty_colorful_config = 1

" ===== Folds

set nofoldenable

" ===== Statusline & Linting

" Run prettier on save, async
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

let g:ale_sign_error = '😭'

" Always show ale column
let g:ale_sign_column_always = 1

" Show modified buffers
let g:buftabline_indicators = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

function! LintStatus()
  let status = ALEGetStatusLine()

  if status != ''
    return '['.status.']'
  else
    return ''
endfunction

set statusline=
set statusline +=%1*\ \%{toupper(mode())}\ \%*
set statusline +=%2*%f%*
set statusline +=%2*%=\ \[%{fugitive#head()}]\ \%*
set statusline +=%2*%{LintStatus()}\ \%*
