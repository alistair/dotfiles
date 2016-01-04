call neobundle#append()

NeoBundle 'vim-scripts/bufkill.vim'

" Snippets
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'


NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
NeoBundle 'int3/vim-extradite'


NeoBundle 'kien/ctrlp.vim'
NeoBundleLazy 'scrooloose/nerdtree', { 'augroup' : 'NERDTree' }
NeoBundleSource 'nerdtree'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'majutsushi/tagbar'
" NeoBundle 'jasoncodes/ctrlp-modified.vim'               " open modified files on branch / workspace
" NeoBundle 'kaneshin/ctrlp-git-log'                      " extends above

NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'tpope/vim-dispatch'

NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'editorconfig/editorconfig-vim'                 " EditorConfig support for cross-editor settings

" NeoBundle 'edsono/vim-matchit'                          " makes % match multiple characters.... tags related it seems
NeoBundle 'gregsexton/gitv'                               " gitk for vim

" NeoBundle 'flazz/vim-colorschemes'

call neobundle#end()
