" source plugins {{{
let s:neobundle_path = expand('~/.vim/bundle/neobundle.vim/')
if isdirectory(s:neobundle_path)
    source ~/.vimrc_plugins
endif
unlet s:neobundle_path 
" }}}

" settings {{{
filetype plugin indent on           " enable FileType
syntax on                           " シンタックスをオンに
set nocompatible                    " viとの互換を切る
set hidden                          " バッファを保存しなくても他のバッファを表示できるように
set showmatch                       " 対応する括弧を表示
set showcmd                         " 入力中のコマンドを表示
set number                          " 行番号表示
set autoindent                      " オートインデント
set shiftwidth=4                    " オートインデント時の空白数
set splitbelow                      " 上下に新しいウィンドウを開いたときは下に
set splitright                      " 左右に新しいウィンドウを開いたときは右に
set ignorecase                      " 検索時、小文字のみなら、小文字大文字を区別しない
set smartcase                       " 検索時、大文字があるときは、小文字大文字を区別する
set wildmenu                        " コマンドラインモード時に補完を有効化
set hlsearch                        " 検索したワードをハイライト表示
set vb t_vb=                        " ベルは鳴らさない
set backspace=indent,eol,start      " <BS>で改行文字等を削除できるように
set ambiwidth=double                " Ambiguous文字の幅を二倍に。全角記号対策
set pumheight=7                     " ポップアップメニューのアイテム数は7
set foldmethod=marker               " 折り畳みはmarkerで
let loaded_matchparen = 1           " 対応する括弧のハイライトを表示しない
set nrformats-=octal                " ^a^xの時に8進数(先頭に0がつく場合)は無視
set list                            " 記号を可視化
set lcs=tab:>-                      " 可視化の設定

set expandtab                       " タブはスペースで
set tabstop=4                       " タブ１つはスペース４つ分
" Makefile だけはタブを使う
augroup Makefile
    autocmd!
    autocmd FileType make set noexpandtab
augroup END
" }}}

" Encoding settings : utf-8{{{

set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ascii,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformat=unix
set fileformats=unix,dos,mac

" }}}

" statusline settings {{{
set laststatus=2                    "ステータスラインを表示
" 通常表示
"set statusline=%F%m%r%h%w%=\ %{'[Encoding:'.(&fenc!=''?&fenc:&enc).'][Format:'.&ff.']'}[Length:%04l\/%04L][Pos:%04l,%04v][%03p%%]
" シンプル表示（できるだけスペースを省略）
"set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v][%03p%%]
" シンプル表示:2（できるだけスペースを省略 + % 無し）
set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v]

" }}}

" commands {{{
command! ReloadVimrc source $MYVIMRC
command! EditVimrc edit $MYVIMRC
command! EditVimrcPlugins edit ~/.vimrc_plugins
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
nnoremap <C-h> :h 


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

" other settings {{{

" Ruby 用の設定
augroup Ruby
    autocmd!
    autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab
augroup END

" Undo履歴を保存する
if has('persistent_undo')
    set undodir=~/.vim/undo_history
    set undofile
endif

" }}}

" files template {{{

augroup FileTemplate
    autocmd!
    autocmd BufNewFile *.rb  0r ~/.vim/templates/ruby.rb
    autocmd BufNewFile *.php 0r ~/.vim/templates/php.php
    autocmd BufNewFile *.tex 0r ~/.vim/templates/tex.tex
augroup END

" }}}

" color settings {{{

highlight Pmenu     ctermbg = grey
highlight PmenuSel  ctermbg = darkcyan
highlight PMenuSbar ctermbg = grey

" }}}
