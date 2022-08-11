" Load plugins.
set nocompatible
so ~/.vim/plugins.vim

" Enforce utf-8 encoding.
set encoding=utf-8

" Keep 8 lines above or above when scrolling.
set scrolloff=8

" Don't throw warnings when closing buffers.
set hidden

" Better `j` `k` binding that works even for wrapped lines.
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" Automatically center on search results.
noremap n nzz
noremap N Nzz

" Better search autocompletion.
set wildmode=longest,full

" Macros for building java, python, etc
" Script taken from @rekinyz
" https://stackoverflow.com/questions/6411979/compiling-java-code-in-vim-more-efficiently
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!gcc % -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
exec "!g++ % -o %<"
exec "!time ./%<"
elseif &filetype == 'java'
exec "!javac %"
exec "!time java -cp %:p:h %:t:r"
elseif &filetype == 'sh' exec "!time bash %"
elseif &filetype == 'python'
exec "!time python %"
elseif &filetype == 'html'
exec "!google-chrome % &" elseif &filetype == 'go' exec "!go build %<" exec "!time go run %"
elseif &filetype == 'mkd'
exec "!~/.vim/markdown.pl % > %.html &"
exec "!google-chrome %.html &"
endif
endfunc

" Enable system clipboard.
set clipboard=unnamedplus

" Show line numbers.
set number

" Load bat(improved version of cat) style color scheme.
set termguicolors
colorscheme bat
" Hightlight the current line.
set cursorline

" vim-gitgutter configs.
set updatetime=100
highlight SignColumn guibg=#373737
set signcolumn=number

" vim-indent-guides configs.
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" YouCompleteMe Python configs.
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'

" Load vim-prettier package.
packloadall

" vim-airline configs.
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline_theme = 'minimalist'
let g:airline_theme = 'base16_spacemacs'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#displayed_head_limit = 10

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 2

let g:airline_extensions = []

let g:airline_section_b = '%-0.10{FugitiveHead()}'
let g:airline_section_c = '%t'
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_y = 'hello world'
let g:airline_section_z = '%l:%c %p%% %L☰'

let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }
