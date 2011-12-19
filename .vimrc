" Vundle の設定
filetype off							"一度FileTypeをオフに
"set rtp+=~/.vim/vundle.git/			"Vundleの初期化 (Vundleのみが .vim に入っているとき)
set rtp+=~/.vim/bundle/vundle			"Vundleの初期化 (VundleもVundleで管理しているとき)
call vundle#rc()						"Vundleの初期化
"使用するプラグインを指定

Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache.git'
Bundle 'Shougo/vimshell.git'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'quickrun.vim'
"Bundle 'ref.vim'
"Bundle 'neco-look'
"Bundle 'tyru/eskk.vim'
"Bundle 'kana/vim-smartchr'

filetype plugin indent on				"FileTypeを再適用


" 各種設定
syntax on                   
set nocompatible					"viとの互換を切る
set showmatch						"対応する括弧を表示
set tabstop=4						"タブ１つはスペース４つ分
set number							"行番号表示
set autoindent						"オートインデント
set smartindent						"高度なオートインデント
"set cindent						"オートインデント（C向け）
set shiftwidth=4					"オートインデント時の空白数
set splitbelow						"上下に新しいウィンドウを開いたときは下に
set splitright						"左右に新しいウィンドウを開いたときは右に
set ignorecase						"検索時、小文字のみなら、小文字大文字を区別しない
set smartcase						"検索時、大文字が入っていときは、小文字大文字を区別する
set wildmenu						"コマンドモード時に補完を有効化
set backspace=indent,eol,start		"<BS>で改行文字等を削除できるように

"エンコーディングはUTF-8
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformat=unix
set fileformats=unix,dos,mac


" ステータスバーの設定
set laststatus=2					"ステータスバーを表示
" 通常表示
"set statusline=%F%m%r%h%w%=\ %{'[Encoding:'.(&fenc!=''?&fenc:&enc).'][Format:'.&ff.']'}[Length:%04l\/%04L][Pos:%04l,%04v][%03p%%]
" シンプル表示（できるだけスペースを省略）
"set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v][%03p%%]
" シンプル表示:2（できるだけスペースを省略 + % 無し）
set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v]


"keymaps
"YでDのように行末まで
nnoremap Y y$
"ノーマルモード時に<tab>でタブ切り替え(次へ）
nnoremap <tab> gt         
"ノーマルモード時に<S-tab>でタブ切り替え(戻る）
nnoremap <S-tab> gT
"インサートモード時に<C-f>でカーソルを右へ移動
inoremap <unique><C-f> <Right>
"インサートモード時に<C-f>でカーソルを左へ移動
inoremap <unique><C-b> <Left>
"VimShell用のショートカット
cnoremap <silent>vsh<CR> VimShellTab<CR>
"QuickRun用のショートカット
nmap <C-k> <Plug>(quickrun)


" Omni補完用の設定
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP						"PHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete								"C
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags				"HTML
"autocmd FileType java setlocal omnifunc=javacomplete#Complete					"java
"autocmd FileType java setlocal cfu=VjdeCompleteFun
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS			"JavaScript
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete					"ruby


" quickrun
let g:quickrun_config={'*': {'split': ''}}				"起動時は横分割(上下に)


" smartchr

" 各種演算子の前後に空白を入れる
"inoremap <buffer><expr> + smartchr#one_of(' + ' , '++' , '+')
"inoremap <buffer><expr> - smartchr#one_of(' - ' , '--' , '-')
"inoremap <buffer><expr> * smartchr#one_of(' * ' , '*');
"inoremap <buffer><expr> / smartchr#one_of(' / ' , '/')

"  < と > は、#includeがある時は空白を入れない
"inoremap <buffer><expr> < search('^#include\%#', 'bcn')? ' <': smartchr#one_of(' < ', ' << ', '<')
"inoremap <buffer><expr> > search('^#include <.*\%#', 'bcn')? '>': smartchr#one_of(' > ', ' >> ', '>')

"  & と | は && と|| の時だけ空白を入れる
"inoremap <buffer><expr> & smartchr#one_of('&' , ' && ')
"inoremap <buffer><expr> <bar> smartchr#one_of('<bar>' , ' <bar><bar> ')
 
"  = の設定
" 代入や比較時は前後に空白
" 複合演算代入時は直前のスペースを削除して入力
"inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= ' : search('\(*\<bar>!\)\%#', 'bcn') ? '= ' : smartchr#one_of(' = ', ' == ', '=')

"  .. で ->
"inoremap <buffer><expr> . smartchr#loop('.', '->', '...')

" .txtのファイルの時は無効化させる（上記で設定したinoremapを上書き）
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> = =
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> + +
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> - -
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> / /
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> > >
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> < <
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> & &
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> . .
"autocmd BufReadPost,BufNewFile *.txt inoremap  <buffer> <bar> <bar>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1						" 起動時に有効化
let g:neocomplcache_enable_underbar_completion = 1				" _の補完を有効化
autocmd BufReadPost,BufNewFile *.txt let g:neocomplcache_enable_at_startup = 0	".txtファイルを編集するときは無効化

" neocomplcacheのスニペットを<C-k> にマッピング
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)


"" tabで補完
"     function InsertTabWrapper()
"if pumvisible()
"     return "\<c-n>"
"     endif
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k\|<\|/'
"     return "\<tab>"
"     elseif exists('&omnifunc') && &omnifunc == ''
"     return "\<c-n>"
"     else
"     return "\<c-x>\<c-o>"
"     endif
"     endfunction
"Tab補完無効化のためにinoremapをコメントアウト
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"
"" Shift + tabで補完を逆順に移動
"     function ShiftTabWrapper()
"if pumvisible()
"     return "\<c-p>"
"     endif
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k\|<\|/'
"     return "\<s-tab>"
"     elseif exists('&omnifunc') && &omnifunc == ''
"     return "\<c-p>"
"     else
"     return "\<c-x>\<c-o>"
"     endif
"     endfunction
""Shift+Tab補完無効化のためにinoremapをコメントアウト
"inoremap <s-tab> <c-r>=ShiftTabWrapper()<cr>


" 色の設定
highlight Pmenu ctermbg=grey
highlight PmenuSel ctermbg=darkcyan
highlight PMenuSbar ctermbg=grey
