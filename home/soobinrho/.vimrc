" Load plugins.
set nocompatible
so ~/.vim/plugins.vim

" Enforce utf-8 encoding.
set encoding=utf-8

" Keep 8 lines above or above when scrolling.
set scrolloff=8

" vim-neomake configs.
let neomake_verbose = 2

" Enable syntax highlighting.
syntax on

" Better `j` `k` binding that works even for wrapped lines.
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" Automatically center on search results.
noremap n nzz
noremap N Nzz

" Macros for building java, python, etc
" Script taken from @rekinyz
" https://stackoverflow.com/questions/6411979/compiling-java-code-in-vim-more-efficiently
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'python'
        exec "Start! -wait=always time python %"
    elseif &filetype == 'c'
        exec "Start! -wait=always gcc % -o %< && time ./%<"
    elseif &filetype == 'cpp'
        exec "Start! -wait=always g++ % -o %< && time ./%<"
    elseif &filetype == 'html'
        exec "!google-chrome % &" 
    elseif &filetype == 'markdown'
        exec "Start! -wait=always glow %"
    elseif &filetype == 'sh' 
        exec "Start! -wait=always time bash %"
    elseif &filetype == 'java'
        exec "Start! -wait=always javac % && time java -cp %:p:h %:t:r"
    elseif &filetype == 'go' 
        exec "Start! -wait-always go build %< && time go run %"
    endif
endfunc

" Enable system clipboard.
set clipboard=unnamedplus

" Show line numbers.
set number

" Hightlight the current line.
set cursorline

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
let g:airline#extensions#wordcount#enabled = 0
let g:airline_theme = 'base16_spacemacs'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    let g:airline_symbols.branch = ''
    let g:airline_symbols.colnr = ' ℅:'
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ' :'
    let g:airline_symbols.maxlinenr = '☰ '
    let g:airline_symbols.dirty='⚡'
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline_section_b = '%-0.10{FugitiveHead()}'
let g:airline_section_c = '%t'
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c %p%% %L'
let g:airline_section_error = ''
let g:airline_section_warning = ''

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

" Load bat(improved version of cat) style color scheme.
set termguicolors
colorscheme bat

" Ale configs.
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_set_highlights = 0
highlight ALEErrorSign guibg=#373737
highlight ALEWarningSign guibg=#373737

" vim-gitgutter configs.
set updatetime=100
set signcolumn=number
highlight SignColumn guibg=#373737
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_removed_above_and_below = ''
let g:gitgutter_sign_modified_removed = ''

