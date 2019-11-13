call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'Valloric/YouCompleteMe'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'mcchrish/nnn.vim'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'

" Test Coverage PlugIns
Plug 'buoto/gotests-vim'

" Colorschemes
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'ayu-theme/ayu-vim'
Plug 'kaicataldo/material.vim'
Plug 'rakr/vim-one'


call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
set cmdheight=1
set colorcolumn=81                " highlight the 80th column as an indicator
set completeopt-=preview          " remove the horrendous preview window
set cursorline                    " highlight the current line for the cursor
set encoding=utf-8
set expandtab                     " expands tabs to spaces
set hidden
set list                          " show trailing whitespace
set listchars=tab:\|\ ,trail:▫
set nospell                       " disable spelling
set noswapfile                    " disable swapfile usage
set nowrap
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set number                        " show number ruler
set relativenumber                " show relative numbers in the ruler
set ruler
set formatoptions=tcqronj         " set vims text formatting options
set softtabstop=4
set shiftwidth=4
set signcolumn=yes
set tabstop=4
set title                         " let vim set the terminal title
set updatetime=10
" set wrap                          " wordwrap bitches
"----------------------------------------------
" Colors/Misc
"----------------------------------------------
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set background=dark

" Material colorscheme settings
let g:material_theme_style = 'dark'

" Ayu colorscheme settings
let ayucolor = 'dark'

" One colorscheme settings
let g:one_allow_italics = 1

colorscheme one

" Override the search highlight color with a combination that is easier to
" read. The default PaperColor is dark green backgroun with black foreground.
"
" Reference:
" - http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
highlight Search guibg=DeepPink4 guifg=White ctermbg=53 ctermfg=White

" Toggle background with <leader>bg
map <leader>bg :let &background = (&background == "dark"? "light" : "dark")<cr>

let g:csv_delim = ','

inoremap jj <Esc>
map nt :NERDTree<Enter>
map gt <C-]>
map gb <C-t>

" Toggle test coverage ON and OFF
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" Add Newlines to file
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
"---------------------------------------------
" Plugin: delimitMate
"----------------------------------------------
let delimitMate_expand_cr = 1

"----------------------------------------------
" Plugin: buoto/gotests-vim
"----------------------------------------------
let g:gotests_bin = '/home/devinfrancis/go/bin/gotests'

"----------------------------------------------
" Plugin: itchyny/lightline.vim
"----------------------------------------------
let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ }

"----------------------------------------------
" Plugin: zchee/deoplete-go
"----------------------------------------------
" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1

" Enable autocomplete of unimported packages
let g:deoplete#sources#go#unimported_packages = 0 

"----------------------------------------------
" Plugin: tpope/vim-markdown
"----------------------------------------------
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

"----------------------------------------------
" Plugin: mattn/emmet-vim
"----------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType, html,css EmmetInstall

"----------------------------------------------
" Plugin: neoclide/coc.nvim
"----------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"----------------------------------------------
" Plugin: mcchrish/nnn.vim
"----------------------------------------------
"" Disable default mappings
let g:nnn#set_default_mappings = 0

" Start nnn in the current file's directory
nnoremap <leader>n :NnnPicker '%:p:h'<CR>

" Opens the nnn window in a split
let g:nnn#layout = 'new' " or vnew, tabnew etc.

let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

"----------------------------------------------
" Language: Golang
"----------------------------------------------

" Mappings
au FileType go nmap <F8> :GoMetaLinter<cr>
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F12> <Plug>(go-def)
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
au FileType go nmap <leader>gdh <Plug>(go-def-split)
au FileType go nmap <leader>gD <Plug>(go-doc)
au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Set neosnippet as snippet engine
let g:go_snippet_engine = "neosnippet"

" Enable syntax highlighting per default
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" Show type information
let g:go_auto_type_info = 1

" Highlight variable uses
let g:go_auto_sameids = 1

" Fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" Add the failing test name to the output of :GoTest
let g:go_test_show_name = 1

" gometalinter configuration
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "5s"
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'golint',
    \ 'gosimple',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "snakecase"

" neomake configuration for Go.
let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }

"---------------------------------------------------
" YCM
"---------------------------------------------------
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
