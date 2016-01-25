if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let g:neobundle#types#git#default_protocol='ssh'
" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'



" My Bundles
" NeoBundle 'daylerees/colour-schemes', { "rtp" : "vim/" } " Removed as not using currently
NeoBundle 'altercation/vim-colors-solarized'

" Language Bundles
NeoBundle 'derekwyatt/vim-scala'
" NeoBundle 'elzr/vim-json'                               "https://github.com/elzr/vim-json
" NeoBundle 'gre/play2vim'                                " Syntax hightlighting for play framework


" Html Bundles
NeoBundle 'ap/vim-css-color'
NeoBundle 'mattn/emmet-vim'
"NeoBundle 'docunext/closetag.vim'  " http://www.vim.org/scripts/script.php?script_id=13
NeoBundle 'groenewege/vim-less'   " Less syntax

"
"
" General Bundles
" NeoBundle 'duff/vim-bufonly'      " Close multiple buffers
" NeoBundle 'godlygeek/tabular'     " Configurable, flexible, intuitive text aligning
NeoBundle 'MarcWeber/vim-addon-mw-utils'
" NeoBundle 'tomtom/tlib_vim'

" NeoBundle 'SirVer/ultisnips'
" NeoBundle 'garbas/vim-snipmate'
" NeoBundle 'honza/vim-snippets'    " Snippets
" NeoBundle 'jiangmiao/auto-pairs'  " bracket pairs
" NeoBundle 'kshenoy/vim-signature'
" NeoBundle 'lokaltog/vim-easymotion'


" Required:
call neobundle#end()

source ~/dotfiles/vim.bundles.d/000_toplaywith.vim
source ~/dotfiles/vim.bundles.d/001_general.vim
source ~/dotfiles/vim.bundles.d/002_tmux.vim
source ~/dotfiles/vim.bundles.d/003_haskell.vim
source ~/dotfiles/vim.bundles.d/004_javascript.vim
source ~/dotfiles/vim.bundles.d/010_dotnet.vim

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" ==================
" Basics
" ==================
set mouse=a		            " Always enable mouse
set clipboard+=unnamed	  " Makes using clipboard easier
set relativenumber
"set number                " Show line numbers
set numberwidth=1         " Try to use only 1 col when possible
set nowrap                " Line wrapping off
" set cursorline          " Highlight line cursor is on
" set cursorcolumn        " Highlight column cursor is on
set autoread              " Reloads file if changed on disk
set completeopt-=preview  " Turn scratch window off
set hidden                " Switch between buffers without saving
set lazyredraw            " This stops vim from redrawing during complex operations and results in smoother looking plugins
"map <F7> :setlocal spell! spelllang=en_nz<CR>

" \v brings up .vimrc
" \V reloads it (as long as you remember to save it first)
map <leader>v :sp ~/.vimrc<CR><C-W>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Ignore loads of stuff
set wildignore+=*/tmp/*.*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]\.(git|hg|svn|target)$',
      \ 'file': '\v\.(exe|so|dll|class)$',
      \ }

let g:ctrlp_by_filename = 1

" Turn off F1 help
map <F1> <Nop>

"
" Moving around / editing
"
set nostartofline         " Avoid moving cursor to BOL when moving
set scrolloff=5           " Keep 5 lines (top/bottom> for scope
set backspace=2           " Allow backspace over autoindent, EOL, and BOL
set showmatch             " Show matched paren when balanced
set matchtime=2           " for .2 seconds
set linebreak             " Don't wrap text in the middle of a word


"
" Search / Replace
"
set incsearch             " Show best match while typing a search
set ignorecase            " Case insensitive search
set smartcase             " Unless uppercase used in search expr
set gdefault              " Default to /g global replace
set hlsearch              " Highlight searches and search results
" clear highlighted search using the space bar
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>


"
" Messages, Info & Status
"
set vb t_vb=              " No bells. Period
set novisualbell          " No blinking
set noerrorbells          " No Noise
set cmdheight=2           " Cmd bar 2 rows high
set showcmd               " Show partial command in the last line of the screen
set report=0              " : commands always print changed line count
set shortmess+=a          " Use [+]/[R0]/[w] for modified/readonly/written
set laststatus=2          " Always show the status line
set ruler                 " Display position in the file

"
" Tabs / indentation
"
set shiftwidth=2          " Indent level is 2 spaces wide
set softtabstop=2         " <BS> over an autoindent deletes shiftwidth worth of spaces
set tabstop=2
set smarttab              " Insert blanks properly at beginning of a line
set autoindent            " Copy indent from current line when starting a new line
set expandtab             " Use spaces not tabs

" Show all tab chars and trailing whitespace
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:.
set list
" Hightlight SpecialKey guifg=#000000

" Some file type really do require explicit tabs
autocmd FileType make	set noexpandtab

"
" Reading/Writing
"
set noautowrite           " Never write a file unless requested to
set noautowriteall        " I mean it
set modeline              " Let vim options be embedded in files;
set modelines=5           " when in first or last 5 lines
set ffs=unix,dos,mac      " Try and recognise line endings in that order
set noswapfile            " No swapfile

"
" Command Line
"
set history=1000          "Remember a long command history
set wildmenu              " Menu completion in command mode on <Tab>
" First list the available options and complete the longest common part, then have further <Tab>s cycle through the possibilities
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,*.pyc.,*.dll,*.orig

" Linux / Mac
set wildignore+=*/.git/*

" Teach vim where to find the ctags file
set tags=./.git/tags,tags,./.git/coffeetags,coffeetags;$HOME

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"
" Per-FileType Scripts
"
syntax enable                 " Enable per-filetype sytax highlighting
filetype on               " File type detection on
filetype indent on        " Use filetype-specific indenting when available
filetype plugin on        " Load filetype plugins

set background=dark
colorscheme solarized

let g:OmniSharp_server_type = 'roslyn'
