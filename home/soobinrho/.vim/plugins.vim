" vim-polyglot configs.
let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'junegunn/fzf'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ycm-core/YouCompleteMe'
Plug 'jamespwilliams/bat.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Plugin for automatically saving open buffers
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" airline plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" nvim-tree
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

call plug#end()
