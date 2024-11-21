call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'schickling/vim-bufonly'
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-lsp-ale'
Plug 'sheerun/vim-polyglot'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'andreypopp/asyncomplete-ale.vim'

Plug 'prabirshrestha/asyncomplete.vim'
if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

call plug#end()
set nocompatible

filetype plugin indent on
syntax on

set notermguicolors
let g:seoul256_light_background = 256
colo seoul256-light
set background=light

set number
set mouse=a
set backspace=indent,eol,start "Allow backspace in insert mode
set history=1000
set showcmd "Show incomplete cmds down the bottom
set showmode "Show current mode down the bottom
set visualbell "No sounds
set autoread "Reload files changed outside vim
set clipboard=unnamed
set hidden
set list listchars=tab:\ \ ,trail:· "Display tabs and trailing spaces visually
set incsearch
set nohlsearch

set nowrap
set linebreak
set laststatus=2 "Always show status bar

command! W w
command! Wqall wqall
command! WQall wqall
command! Q q
command! Qall qall

nmap <TAB> >>

set directory:~/.vim/swapfiles//
set backupdir:~/.vim/backup//

set nowb
set nofoldenable
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

au Filetype css,html,jsx set iskeyword+=-

if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

let g:toggle_list_no_mappings = 1

" LSP
nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>k :call ToggleQuickfixList()<CR>
nmap <script> <silent> <leader>q :bdel<CR>

nnoremap <silent> K :LspHover<CR>
autocmd FileType vim nnoremap <silent> <buffer> K :help <CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gD :LspPeekDefinition<CR>
nnoremap <silent> <Leader>R :LspRename<CR>
nnoremap <silent> <Leader>E :LspDocumentDiagnostics<CR> :lopen<CR> :let w:quickfix_title = "LSP Diagnostics"<CR> :lfirst<CR>
nnoremap <silent> <leader>A :LspCodeAction<CR>

" Settings: https://github.com/prabirshrestha/vim-lsp/blob/master/doc/vim-lsp.txt
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 150
let g:lsp_diagnostics_float_insert_mode_enabled = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_highlights_delay = 0
highlight lspReference ctermbg=242 ctermfg=yellow
let g:lsp_diagnostics_signs_delay = 0
let g:lsp_hover_conceal = 1
let g:markdown_syntax_conceal = 1
let g:markdown_fenced_languages = ["javascript"]
let g:lsp_diagnostics_virtual_text_enabled = 0
set conceallevel=2
let g:lsp_settings = {
\   "typescript-language-server": {
\     "workspace_config": {
\       "diagnostics": {
\         "ignoredCodes": [80001, 7016]
\       }
\     }
\   }
\ }
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" Ale
let g:ale_disable_lsp = 1 "no lsp from ale"
let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['eslint']}
let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['eslint']}
let g:ale_fix_on_save = 1

" FZF
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all,ctrl-d:deselect-all'
nmap <leader>f :FZF<CR>
nmap <leader>b :Buffers<CR>

" Autocomplete
set completeopt+=menuone
set completeopt+=noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

if has('python3')
    let g:UltiSnipsExpandTrigger="<c-e>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

" Statusline
set statusline =
set statusline+=%#warningmsg#
set statusline+=%*

set statusline +=%2*%f
set statusline +=\ %m
set statusline +=%1*\ %=
