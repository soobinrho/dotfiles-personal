-- ##############################
-- Basic Settings
-- ##############################
-- Taken from:
-- https://github.com/arnvald/viml-to-lua/blob/main/lua/settings.lua
HOME = os.getenv("HOME")
vim.o.encoding = "utf-8"
vim.o.history = 1000
vim.o.timeout = false
vim.o.ttimeout = true
vim.o.ttimeoutlen = 100
vim.o.showbreak= '↪' -- character to show when line is broken

-- Display
vim.o.showmatch  = true -- show matching brackets
vim.o.scrolloff = 8 -- always show 8 rows from edge of the screen
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2 -- always show status line
vim.g.material_style = "oceanic"

-- Sidebar
vim.o.number = true -- line number on the left
vim.o.numberwidth = 3 -- always reserve 3 spaces for line number
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 0
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//'   -- swap files

-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command

-- Only show cursorline in the current window and in normal mode
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

-- Press <F5> to compile and run
vim.cmd([[
  map <F5> :call CompileRunGcc()<CR>
  func! CompileRunGcc()
    exec "w"
    if &filetype == 'python'
        exec "Start! -wait=always time python %"
    elseif &filetype == 'c'
        exec "Start! -wait=always gcc % -o %< && time ./%<"
    elseif &filetype == 'cpp'
        exec "Start! -wait=always g++ ./%:r*.cpp -o ./_%:r && time ./_%:r && rm ./_%:r"
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
]])

-- Compile init.lua everytime it's modified
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]])


-- ##############################
-- Basic Settings
-- ##############################

