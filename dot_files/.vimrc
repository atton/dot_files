" source plugins {{{
let s:neobundle_path = expand('~/.vim/bundle/neobundle.vim/')
if isdirectory(s:neobundle_path)
    source ~/.vimrc_plugins
endif
unlet s:neobundle_path
" }}}

" settings {{{
filetype plugin indent on           " enable FileType
syntax enable                       " シンタックスを有効化
set background=light                " ターミナルの背景色は白めの場合を想定
set nocompatible                    " viとの互換を切る
set hidden                          " バッファを保存しなくても他のバッファを表示できるように
set showmatch                       " 対応する括弧を表示
set showcmd                         " 入力中のコマンドを表示
set nonumber                        " 行番号非表示
set autoindent                      " オートインデント
set splitbelow                      " 上下に新しいウィンドウを開いたときは下に
set splitright                      " 左右に新しいウィンドウを開いたときは右に
set ignorecase                      " 検索時、小文字のみなら、小文字大文字を区別しない
set smartcase                       " 検索時、大文字があるときは、小文字大文字を区別する
set hlsearch                        " 検索したワードをハイライト表示
set vb t_vb=                        " ベルは鳴らさない
set backspace=indent,eol,start      " <BS>で改行文字等を削除できるように
set ambiwidth=double                " Ambiguous文字の幅を二倍に。全角記号対策
set pumheight=7                     " ポップアップメニューのアイテム数は7
set foldmethod=marker               " 折り畳みはmarkerで
let loaded_matchparen = 1           " 対応する括弧のハイライトを表示しない
set nrformats-=octal                " ^a^xの時に8進数(先頭に0がつく場合)は無視
set list                            " 記号を可視化
set listchars=tab:>-                " 可視化の設定

" save undo history
if has('persistent_undo')
    set undodir=~/.vim/undo_history
    set undofile
endif

" tab settings {{{
set expandtab               " use space
let s:tab_width = 4         " common tab width
execute 'set tabstop='    . s:tab_width
execute 'set shiftwidth=' . s:tab_width
execute 'set tabstop='    . s:tab_width
unlet s:tab_width

" use \t in only Makefile
augroup Makefile
    autocmd!
    autocmd FileType make set noexpandtab
augroup END
" }}}

" wild settings {{{
set wildmenu                        " enable wild
" wild ignore settings
let s:wildignore_files =
            \ '.*.sw[a-z],' . '*.un~,' . 'Session.vim,' . '.netrwhist,' .
            \ '.DS_Store,' . '.AppleDouble,' . '.LSOverride,' . 'Icon,' .
            \ '._*,' . '.Spotlight-V100,' . '.Trashes,' .
            \ '.git,' . '.hg,' .
            \ 'a.out,' . '*.o,' . '*.class,' .
            \ '*.jpg,' . '*.png,' . '*.gif,' . '*.eps,' .
            \ '*.aux,' . '*.dvi,' . '*.toc,' . '*.pdf,' .
            \ '*.zip,'
execute 'set wildignore=' . s:wildignore_files
unlet s:wildignore_files
" }}}

" }}}

" Encoding settings : utf-8 {{{
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ascii,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformat=unix
set fileformats=unix,dos,mac
" }}}

" statusline and ruler settings {{{
set laststatus=2                    " usually show status line
" 通常表示
"set statusline=%F%m%r%h%w%=\ %{'[Encoding:'.(&fenc!=''?&fenc:&enc).'][Format:'.&ff.']'}[Length:%04l\/%04L][Pos:%04l,%04v][%03p%%]
" シンプル表示（できるだけスペースを省略）
"set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v][%03p%%]
" シンプル表示:2（できるだけスペースを省略 + % 無し）
set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v]

" simple ruler (only modified flag)
set ruler                           " show ruler, but usually hidden by statusline
set rulerformat=%m
" }}}

" commands {{{
command! ReloadVimrc source $MYVIMRC
command! EditVimrc edit $MYVIMRC
command! EditVimrcPlugins edit $HOME/.vimrc_plugins
command! SudoWriteCurrentBuffer write !sudo tee %
command! DeleteTrailingSpaces %s/\s\+$//ge

function! ShowTrailingSpacesFunc()
    highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    match TrailingSpaces /\s\+$/
endfunction
command! ShowTrailingSpaces call ShowTrailingSpacesFunc()

function! ToggleLastStatusFunc()
    let s:enable_last_status  = 2
    let s:disable_last_status = 0

    if(&laststatus == s:enable_last_status)
        let &laststatus = s:disable_last_status
    else
        let &laststatus = s:enable_last_status
    end
endfunction
command! ToggleLastStatus call ToggleLastStatusFunc()

function! ToggleWildIgnoreFunc()
    if (&wildignore != '')
        let s:wildignore_backup = &wildignore
        let &wildignore = ''
    else
        if(exists('s:wildignore_backup'))
            let &wildignore = s:wildignore_backup
        endif
    endif
endfunction
command! ToggleWildIgnore call ToggleWildIgnoreFunc()
" }}}

" keymaps {{{
" YでDのように行末まで
nnoremap Y y$
" インサートモード時に<C-f>でカーソルを右へ移動
inoremap <C-f> <Right>
" インサートモード時に<C-f>でカーソルを左へ移動
inoremap <C-b> <Left>
" ^lで検索ハイライトを消す
nnoremap <C-l> :nohlsearch<CR><C-l>
" ^h でヘルプへのショートカット
nnoremap <C-h> :h<Space>


" command line mode のカーソル移動を zsh likeに
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-f> <RIGHT>
cnoremap <C-b> <LEFT>
cnoremap <C-d> <DEL>


" undoのポイントを追加するところ
inoremap <CR> <C-g>u<CR>
inoremap <C-@> <C-g>u<C-@>

" }}}

" autocmds {{{

" for Ruby
augroup Ruby
    autocmd!
    autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab
augroup END

" for TeX
augroup TeX
    autocmd!
    autocmd BufNewFile *.tex setl filetype=tex
    autocmd BufRead    *.tex setl filetype=tex
    autocmd FileType tex nnoremap <C-K> :make<CR>
augroup END

" for Processing(*.pde)
" set filetype
augroup Processing
    autocmd!
    autocmd BufNewFile *.pde setl filetype=java
    autocmd BufRead    *.pde setl filetype=java
augroup END

" Omni Completion dictionary {{{
augroup OmniCompletionDictionary
    autocmd!
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType c setlocal omnifunc=ccomplete#Complete
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END
" }}}

" files template {{{

augroup FileTemplate
    autocmd!
    autocmd BufNewFile *.rb  0r ~/.vim/templates/ruby.rb
    autocmd BufNewFile *.php 0r ~/.vim/templates/php.php
    autocmd BufNewFile *.tex 0r ~/.vim/templates/tex.tex
augroup END

" }}}

" }}}

" color settings {{{

highlight Pmenu     ctermbg = grey
highlight PmenuSel  ctermbg = darkcyan
highlight PMenuSbar ctermbg = grey

" }}}
