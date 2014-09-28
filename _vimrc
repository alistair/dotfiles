"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=/home/alistair/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/alistair/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Default NeoBundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" My Bundles
NeoBundle 'daylerees/colour-schemes', { "rtp" : "vim/" }
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'editorconfig/editorconfig-vim'                 " EditorConfig support for cross-editor settings
" NeoBundle 'edsono/vim-matchit'                          " makes % match multiple characters.... tags related it seems
NeoBundle 'gregsexton/gitv'                               " gitk for vim
" NeoBundle 'jasoncodes/ctrlp-modified.vim'               " open modified files on branch / workspace
" NeoBundle 'kien/ctrlp.vim'
" NeoBundle 'kaneshin/ctrlp-git-log'                      " extends above

" Language Bundles
NeoBundle 'derekwyatt/vim-scala'
" NeoBundle 'elzr/vim-json'                               "https://github.com/elzr/vim-json
NeoBundle 'gre/play2vim'                                " Syntax hightlighting for play framework


" Html Bundles
NeoBundle 'ap/vim-css-color'
"NeoBundle 'digitaltoad/vim-jade'   " Jade template plugin
"NeoBundle 'docunext/closetag.vim'  " http://www.vim.org/scripts/script.php?script_id=13
" NeoBundle 'groenewege/vim-less'   " Less syntax
" NeoBundle 'hail2u/vim-css3-syntax'
" NeoBundle 'kchmck/vim-coffee-script'
" NeoBundle 'lukaszkorecki/CoffeeTags'

" Tmux plugins
" NeoBundle 'christoomey/vim-tmux-navigator'
" NeoBundle 'edkolev/tmuxline.vim'
"
"
" General Bundles
" NeoBundle 'duff/vim-bufonly'      " Close multiple buffers
" NeoBundle 'godlygeek/tabular'     " Configurable, flexible, intuitive text aligning
" NeoBundle 'honza/vim-snippets'    " Snippets
" NeoBundle 'jiangmiao/auto-pairs'  " bracket pairs
" NeoBundle 'kshenoy/vim-signature'
" NeoBundle 'lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'

" Required:
call neobundle#end()

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
set number		            " Show line numbers
set numberwidth=1	        " Try to use only 1 col when possible
set nowrap		            " Line wrapping off
" set cursorline		      " Highlight line cursor is on
" set cursorcolumn      	" Highlight column cursor is on
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

set t_Co=256
if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
  \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
  " Use the guicolorscheme plugin to makes 256-color or 88-color
  " terminal use GUI colors rather than cterm colors.
  runtime! plugin/guicolorscheme.vim
  GuiColorScheme darkside
else
  " For 8-color 16-color terminals or for gvim, just use the
  " regular :colorscheme command.
  colorscheme darkside
endif

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

"
" Per-FileType Scripts
"
syntax enable                 " Enable per-filetype sytax highlighting
filetype on               " File type detection on
filetype indent on        " Use filetype-specific indenting when available
filetype plugin on        " Load filetype plugins
