" Configuration for VIM editor

" Vundle auto installation
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

" Vundle configuration settings
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" END - Setting up Vundle - the vim plugin bundler

"===================================================================================================
"INSERT PLUGINS AFTER THIS LINE

"NERDTree file browser"
Plugin 'scrooloose/nerdtree'

"NERD Comment"
Plugin 'scrooloose/nerdcommenter'

" Class/module browser
Plugin 'majutsushi/tagbar'

"Airline"
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Surround
Plugin 'tpope/vim-surround'

" Python and other languages code checker
Plugin 'scrooloose/syntastic'

" Solarized theme
Plugin 'altercation/vim-colors-solarized'

" Paint css colors with the real color
Plugin 'lilydjwg/colorizer'

" Git/mercurial/others diff icons on the side of the file lines
Plugin 'mhinz/vim-signify'

" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Plugin 'klen/python-mode'

"Fugitive (Git wreapper)
Plugin 'tpope/vim-fugitive'

"Gundo
Plugin 'sjl/gundo.vim'

"Startify
Plugin 'mhinz/vim-startify'

"Sunset
Plugin 'amdt/sunset'

"===================================================================================================

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Install plugins the first time vim runs
if iCanHazVundle == 0
    echo "Installing plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

"==================================================================================================
" Vim settings and mappings
"==================================================================================================

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set encoding=utf-8
set ruler
set cursorline

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" highlighted search results
set hlsearch

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

"OS cliboard 
set clipboard=unnamed

"Line numbers
set relativenumber
set nu
function! NumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else	  
    set relativenumber
  endif
endfunc
nnoremap <C-l> :call NumberToggle()<cr>

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

set mouse=a


"Colors
set t_Co=256
syntax enable
set background=dark
colorscheme solarized

" Following three lines remove the auto copy function from VIM
set guioptions-=a
set guioptions-=A
set guioptions-=aA

"==================================================================================================
"Plugin settings and mapping
"==================================================================================================

" Tagbar ----------------------------- 

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree ----------------------------- 

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
autocmd BufEnter * lcd %:p:h

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open = 1
" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_json_checkers=['jsonlint']
let g:syntastic_enable_highlighting = 0
autocmd BufNewFile,BufRead *.json set ft=javascript

"Intellisense
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" custom icons (enable them if you use a patched font, and enable the previous 
" setting)
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'

" Python-mode ------------------------------

" don't use linter, we use syntastic for that
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and custom mappings for definitions and
" occurrences
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_options_max_line_length = 120
nmap ,D :tab split<CR>:PymodePython rope.goto()<CR>
nmap ,o :RopeFindOccurrences<CR>

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

"Gundo ---------------------------------

nmap <F2> :GundoToggle<CR>

"Startify ------------------------------

"Sunset --------------------------------
" Automatically set background on local sunrise/sunset time
let g:sunset_latitude = 46.48
let g:sunset_longitude = 11.27

" Daytime color scheme
"function! Sunset_daytime_callback()
"    set background=light
"endfunction

" Night color scheme
"function! Sunset_nighttime_callback()
"    set background=dark
"endfunction
