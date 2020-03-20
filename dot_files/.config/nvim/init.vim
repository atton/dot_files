" .vimrc for plain vim or customized neovim
" https://github.com/neovim/neovim/wiki/Installing-Neovim

" {{{ Set leader
let g:mapleader = ' '               " <Leader> = <Space>
" }}}

" {{{ Source plugins
if (isdirectory(expand('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')) && has('nvim'))
    source ~/.config/nvim/plugins.vim
endif
" }}}

" {{{ Settings

filetype plugin indent on
syntax enable

set nocompatible                " disable vi compatible
set background=light            " terminal back ground color is light
set hidden                      " if buffer unsaved, can show other buffer
set showmatch                   " show match brackets
set showcmd                     " show typing commands
set nonumber                    " disable show line number
set splitbelow                  " open new window in bottom when  split
set splitright                  " open new window in right  when vsplit
set noincsearch                 " disable incremental search
set hlsearch                    " enable word highlighting in search
set ignorecase                  " if search word is small char only, ignore capital/small
set smartcase                   " if search word include capital char, not ignore capital/small
set wildmenu                    " enable command line completion
set wildmode=list:longest       " show longest match with list in command line completion
set visualbell t_vb=            " disable bell
set backspace=indent,eol,start  " set deletable character by <BS>
set ambiwidth=double            " set Ambiguous character width, for Zenkaku character
set pumheight=7                 " pop up items number is 7
set nrformats-=octal            " ignore octal in increment/decrement(^a^x)
set completeopt-=preview        " disable preview in completion
set list                        " show symbols include tab
set listchars=tab:>-            " set list visible style
set autoindent                  " enable autoindent
set spelllang=en,cjk            " treat Japanese in spell check

" {{{ Disable few builtin plugins

let g:loaded_matchparen    = 1
let g:loaded_tar           = 1
let g:loaded_tarPlugin     = 1
let g:loaded_vimball       = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip           = 1
let g:loaded_zipPlugin     = 1

" }}}

" {{{ Specific feature settings

" {{{ color

highlight Pmenu     ctermbg = grey
highlight PmenuSel  ctermbg = darkcyan
highlight PMenuSbar ctermbg = grey

" }}}

" {{{ directory

if has('nvim')
    " swapfile location
    let &directory = expand('~/.config/nvim/swap')
endif

" }}}

" {{{ encoding(utf-8)

if has('vim_starting')
    set termencoding=utf-8
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ascii,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
    set fileformat=unix
    set fileformats=unix,dos,mac
endif

" }}}

" {{{ netrw

let g:netrw_dirhistmax = 0

" }}}

" {{{ folding(marker)

if has('folding')
    set foldmethod=marker       " fold use marker. {{{ }}}
endif

" }}}

" {{{ persistent undo

if has('persistent_undo')
    let &undodir = has('nvim') ? expand('~/.config/nvim/undo_history') : expand('~/.vim/undo_history')
    set undofile
    set undolevels=30000
endif

" }}}

" {{{ ruler

set ruler                           " show ruler, but usually hidden by statusline
set rulerformat=%m                  " simple ruler (only modified flag)

" }}}

" {{{ statusline

set laststatus=0                    " usually hide status line
set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v]

" }}}

" {{{ tab

" usually use space
set expandtab
let s:tab_width  = 4
let &tabstop     = s:tab_width
let &shiftwidth  = s:tab_width
let &softtabstop = s:tab_width
unlet s:tab_width

" use \t in only Makefile
augroup Makefile
    autocmd!
    autocmd FileType make setl noexpandtab
augroup END

" }}}

" {{{ viminfofile

if exists('&viminfofile')
    let &viminfofile = expand('~/.config/') . (has('nvim') ? 'nvim/shada' : 'vim/viminfo')
endif

" }}}

" {{{ wild

set wildmenu                        " enable wild
" wild ignore settings
let s:wildignore_files =
            \ '.*.sw[a-z],' . '*.un~,' . 'Session.vim,' . '.netrwhist,' .
            \ '.DS_Store,' . '.AppleDouble,' . '.LSOverride,' . 'Icon,' .
            \ '._*,' . '.Spotlight-V100,' . '.Trashes,' . 'CMakeFiles,' .
            \ '.git,' . '.hg,' .
            \ 'a.out,' . '*.o,' . '*.class,' .
            \ '*.jpg,' . '*.png,' . '*.bb,' . '*.gif,' . '*.eps,' .
            \ '*.aux,' . '*.dvi,' . '*.toc,' . '*.pdf,' .
            \ '*.zip,'
let &wildignore = s:wildignore_files
unlet s:wildignore_files

" }}}

" }}}

" }}}

" {{{ Functions

function! s:delete_trailing_spaces() abort
    " delete all trailing spaces
    let s:cursor = getpos(".")
    %substitute/\s\+$//ge
    call setpos(".", s:cursor)
endfunction

function! s:toggle_last_status() abort
    " toggle laststatus helper
    let s:enable_last_status_value  = 2
    let s:disable_last_status_value = 0

    if(&laststatus == s:enable_last_status_value)
        let &laststatus = s:disable_last_status_value
    else
        let &laststatus = s:enable_last_status_value
    end
endfunction

function! s:toggle_wild_ignore() abort
    " toggle wildignore settings helper
    let s:enable_last_status_value  = 2
    if (&wildignore != '')
        let s:wildignore_backup = &wildignore
        let &wildignore = ''
        echo "disable wildignore"
    else
        if(exists('s:wildignore_backup'))
            let &wildignore = s:wildignore_backup
            echo "enable wildignore"
        endif
    endif
endfunction

function! s:insert_time_stamps_from_undo_history() abort
    if !has('persistent_undo')
        echomsg 'Undo Tree Unavailale.'
        finish
    endif

    let s:times_from_history = sort(map(undotree()['entries'], 'v:val["time"]'))
    let s:oldest_unix_time   = s:times_from_history[1]
    let s:latest_unix_time   = s:times_from_history[-1]

    call append(line('$'), strftime('%Y/%m/%d %H:%M:%S', s:oldest_unix_time))
    call append(line('$'), strftime('%Y/%m/%d %H:%M:%S', s:latest_unix_time))
endfunction


function! s:sudo_write_current_buffer() abort
    if has('nvim')
        let s:askpass_path = '/tmp/askpass'
        let s:password     = inputsecret("Enter Password: ")
        let $SUDO_ASKPASS  = s:askpass_path

        try
            call delete(s:askpass_path)
            call writefile(['#!/bin/sh'],                 s:askpass_path, 'a')
            call writefile(["echo '" . s:password . "'"], s:askpass_path, 'a')
            call setfperm(s:askpass_path, "rwx------")
            write ! sudo -A tee % > /dev/null
        finally
            unlet s:password
            call delete(s:askpass_path)
        endtry
    else
        write ! sudo tee % > /dev/null
    endif
endfunction

function! s:edit_previous_note() abort
    function! s:error_exit() abort
        echohl NvimInvalid
        echomsg '[EditPreviousNote] Cannot detect the previous note.'
        echohl None
    endfunction

    let s:file_prefix = split(expand('%t'), '_')
    if len(s:file_prefix) != 2
        return s:error_exit()
    endif

    let s:file_prefix = printf('%02d', s:file_prefix[0]-1)
    let s:filename    = expand(s:file_prefix . '_*.txt')
    if filereadable(s:filename)
        execute 'edit ' . s:filename
    else
        return s:error_exit()
    endif
endfunction

" }}}

" {{{ Commands

" shortcut commands
command! E edit! ++enc=utf8 ++ff=unix
command! ExecteCurrentLine exec '!'.getline('.')
command! ReloadVimrc source $MYVIMRC
command! RemovePryPrefix %substitute/\[\d\d*\] pry/pry/gc
command! RemovePryPrefixAll %substitute/\[\d\d*\] pry/pry/g
command! SetFileEncodingUTF8 setl fileencoding=utf8
command! SkkDictionaryCleanup %substitute/^[0-9a-z\u3042-\u3093\u30fc]*\ \/[0-9a-z\u3042-\u3093\u30fc\u3001]*\/$\n//gc

" commands for fuctions
command! InsertTimeStampsFromUndoHistory call s:insert_time_stamps_from_undo_history()
command! PreviousNote                    call s:edit_previous_note()
command! SudoWriteCurrentBuffer          call s:sudo_write_current_buffer()
command! ToggleLastStatus                call s:toggle_last_status()
command! ToggleWildIgnore                call s:toggle_wild_ignore()

" }}}

" {{{ Keymaps
" yank to end of line (D like Y)
nnoremap Y y$
" emacs like cursor move
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" disable hlsearch in redraw
nnoremap <C-l> :nohlsearch<CR><C-l>
" help shortcut
nnoremap <C-h> :h<Space>
" search words shortcut in visual block
vnoremap * y/<C-r>"<CR>


" zsh like cursor move in command line mode
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-f> <RIGHT>
cnoremap <C-b> <LEFT>
cnoremap <C-d> <DEL>


" add undo point map
inoremap <CR>  <C-g>u<CR>
inoremap <C-@> <C-g>u<C-@>

" shortcuts
nnoremap <Leader>l :ToggleLastStatus<CR>
nnoremap <Leader>w :ToggleWildIgnore<CR>
nnoremap <Leader>e :SetFileEncodingUTF8<CR>
nnoremap <Leader>s :setl spell!<CR>
" }}}

" {{{ autocmd

augroup UserDefinedAutocmd
    autocmd!
    autocmd BufNewFile *.rb 0r ~/.config/nvim/templates/ruby.rb
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/shell.sh
    autocmd BufWritePre *   call s:delete_trailing_spaces()
    autocmd FileType eruby  setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType haml   setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType html   setl tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType ruby   setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType slim   setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType yaml   setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType sh     setl commentstring=#\ %s
    autocmd FileType text   setl commentstring=%s
    autocmd FileType vim    setl commentstring=\"\ %s
    autocmd FileType zsh    setl commentstring=#\ %s
    autocmd InsertLeave *   setl nopaste
    autocmd VimEnter *      if exists(':Explore')  | delcommand Explore  | endif
    autocmd VimEnter *      if exists(':Nexplore') | delcommand Nexplore | endif
    autocmd VimEnter *      if exists(':Pexplore') | delcommand Pexplore | endif
augroup END

" {{{ Omni Completion dictionary
augroup OmniCompletionDictionary
    autocmd!
    autocmd FileType c          setlocal omnifunc=ccomplete#Complete
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete

    " default setting : syntax completaion
    autocmd Filetype *
                \   if &l:omnifunc == ''
                \ |   setlocal omnifunc=syntaxcomplete#Complete
                \ | endif
augroup END
" }}}

" }}}
