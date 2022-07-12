" Plugins "
so ~/.vim/plugins.vim

" Lightline can sometimes be 
" not activated by default.
" This line activates it.
set laststatus=2

" We can copy something on to the clipboard on vim 
" and then paste it onto another console by
"
" ```
" v
" "+y
" ctrl+shift+v
" ```
"
" this functionality is not available on normal vim though.
" on fedora, you can use this functionality by installing
" `vimx` and - of course - by using vimx to edit the files.
set clipboard=unnamedplus

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
elseif &filetype == 'sh'
exec "!time bash %"
elseif &filetype == 'python'
exec "!time python2.7 %"
elseif &filetype == 'html'
exec "!firefox % &"
elseif &filetype == 'go'
exec "!go build %<"
exec "!time go run %"
elseif &filetype == 'mkd'
exec "!~/.vim/markdown.pl % > %.html &"
exec "!firefox %.html &"
endif
endfunc
