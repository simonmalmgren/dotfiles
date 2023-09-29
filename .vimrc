call plug#begin('~/.vim/plugged')

Plug 'schickling/vim-bufonly'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'mbbill/undotree'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'Epitrochoid/marko-vim-syntax'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'mustache/vim-mustache-handlebars'
Plug 'iloginow/vim-stylus'
Plug 'ember-template-lint/ember-template-lint'
Plug 'digitaltoad/vim-pug'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/seoul256.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
Plug 'lepture/vim-jinja'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'dense-analysis/ale'

call plug#end()
set nocompatible

filetype plugin indent on
syntax on

set term=xterm-256color
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
set background=dark

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
nmap <leader>e :LspDocumentDiagnostics<CR>

let g:toggle_list_no_mappings = 1

nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>k :call ToggleQuickfixList()<CR>
nmap <script> <silent> <leader>q :bdel<CR>

au Filetype css,html set iskeyword+=-

let g:vim_jsx_pretty_colorful_config = 1 "Allow JSX syntax in non .jsx files

if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

" Ale
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1

set statusline =
set statusline+=%#warningmsg#
set statusline+=%*

set statusline +=%2*%f
set statusline +=\ %m
set statusline +=%1*\ %=

set foldtext=Folding()

function Folding()
  let line = getline(v:foldstart)
  if line =~# " Scenario"
    let line = substitute(line, "(\"", ": ", "")
    let line = substitute(line, "\",.*", "", "")
    return line
  endif

  return substitute(line, "{$", "{…}", "")
endfunction

com FoldFunctions :exe "normal zE" | :g/\<function\>/ :normal $zf%za | :noh
com FoldScenarios :exe "normal zE" | :g/ Scenario/ :normal zf% | :noh
