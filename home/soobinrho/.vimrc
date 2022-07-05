" Settings "

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
"
" Enabling this functionality:
set clipboard=unnamedplus

" Plugins "
so ~/.vim/plugins.vim

" Lightline was not activated by default.
" This line activates it.
set laststatus=2
