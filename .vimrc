" Vundle Settings {{{
filetype off						"一度FileTypeをオフに
"set rtp+=~/.vim/vundle.git/		"Vundleの初期化 (Vundleのみが .vim に入っているとき)
set rtp+=~/.vim/bundle/vundle		"Vundleの初期化 (VundleもVundleで管理しているとき)
call vundle#rc()					"Vundleの初期化
"使用するプラグインを指定

Bundle 'gmarik/vundle'
Bundle 'Shougo/neocomplcache.git'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'Shougo/vimshell.git'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'thinca/vim-ref'
Bundle 'thinca/vim-quickrun'
Bundle 'gregsexton/VimCalc'
Bundle 'ujihisa/neco-ruby'
Bundle 'tyru/skk.vim'
Bundle 'taku-o/vim-toggle'
Bundle 'sjl/gundo.vim'
Bundle 'kana/vim-surround'
Bundle 'h1mesuke/vim-alignta'
Bundle 'yuratomo/w3m.vim'
Bundle 'neco-look'
Bundle 'matchit.zip'

filetype plugin indent on			"FileTypeを再適用
" }}}

" settings {{{
syntax on                   
set nocompatible					"viとの互換を切る
set hidden							"バッファを保存しなくても他のバッファを表示できるように
set showmatch						"対応する括弧を表示
set showcmd							"入力中のコマンドを表示
set tabstop=4						"タブ１つはスペース４つ分
set number							"行番号表示
set autoindent						"オートインデント
"set smartindent					"高度なオートインデント
"set cindent						"オートインデント（C向け）
set shiftwidth=4					"オートインデント時の空白数
set splitbelow						"上下に新しいウィンドウを開いたときは下に
set splitright						"左右に新しいウィンドウを開いたときは右に
set ignorecase						"検索時、小文字のみなら、小文字大文字を区別しない
set smartcase						"検索時、大文字が入っていときは、小文字大文字を区別する
set wildmenu						"コマンドモード時に補完を有効化
set hlsearch						"検索したワードをハイライト表示
set vb t_vb=						"ベルは鳴らさない
set backspace=indent,eol,start		"<BS>で改行文字等を削除できるように
set ambiwidth=double				"Ambiguous文字の幅を二倍に
set pumheight=7						"ポップアップメニューに表示する
set foldmethod=marker				"折り畳みはmarkerで。
let loaded_matchparen = 1			"対応する括弧のハイライトを表示しない

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
set laststatus=2					"ステータスラインを表示
" 通常表示
"set statusline=%F%m%r%h%w%=\ %{'[Encoding:'.(&fenc!=''?&fenc:&enc).'][Format:'.&ff.']'}[Length:%04l\/%04L][Pos:%04l,%04v][%03p%%]
" シンプル表示（できるだけスペースを省略）
"set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v][%03p%%]
" シンプル表示:2（できるだけスペースを省略 + % 無し）
set statusline=%F%m%r%h%w%=\ %{'[E:'.(&fenc!=''?&fenc:&enc).'][F:'.&ff.']'}[L:%04l\/%04L][P:%04l,%04v]

" }}}

"keymaps {{{
"YでDのように行末まで
nnoremap Y y$
"インサートモード時に<C-f>でカーソルを右へ移動
inoremap <unique><C-f> <Right>
"インサートモード時に<C-f>でカーソルを左へ移動
inoremap <unique><C-b> <Left>
"QuickRun用のショートカット
nmap <C-k> <Plug>(quickrun)
"C^lで検索ハイライトを消す
nnoremap <C-l> :nohlsearch<CR><C-l>
"UでUndoTree
nnoremap U :GundoToggle<CR>


" command mode をzsh likeに
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-f> <RIGHT>
cnoremap <C-b> <LEFT>
cnoremap <C-d> <DEL>


"undoのポイントを追加するところ
inoremap <CR> <C-g>u<CR>
inoremap <C-@> <C-g>u<C-@>

" }}}

"ShortCutCommand {{{
"VimShell用のショートカット
command! Vsh VimShellTab

" }}}

" Omni Completion dictionary {{{
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP					"PHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete							"C
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags				"HTML
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS		"JavaScript
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete					"ruby
" }}}

" other settings {{{

" Ruby 用の設定
autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab

"Undo履歴を保存する
if has('persistent_undo')
	set undodir=~/.vim/undo_history							"保存するディレクトリ
	set undofile
endif

" }}}

" files template {{{

autocmd BufNewFile *.rb 0r ~/.vim/templates/ruby.rb			"ruby
autocmd BufNewFile *.php 0r ~/.vim/templates/php.php		"php
autocmd BufNewFile *.tex 0r ~/.vim/templates/tex.tex		"tex

" }}}

" plugins {{{


" quickrun
let g:quickrun_config={'*': {'split': ''}}					"起動時は横分割(上下に)

" neocomplcache
let g:neocomplcache_enable_at_startup = 1					" 起動時に有効化
let g:neocomplcache_enable_underbar_completion = 1			" _の補完を有効化
let g:neocomplcache_temporary_dir = expand('~/.vim/.neocon')

" neocomplcacheのスニペットを <C-k> にマッピング
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" i_^x^gでneocomplcacheを起動
inoremap <expr><c-x><c-g> neocomplcache#start_manual_complete()

" vimshell
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = ''
let g:vimshell_right_prompt = 'getcwd()'
let g:vimshell_temporary_directory = expand('~/.vim/.vimshell')
autocmd FileType vimshell setlocal nonumber			"行番号は表示しない

" unite
let g:unite_update_time = 10
let g:unite_data_directory = expand('~/.vim/.unite')
command! Ub Unite buffer
command! Uf Unite file
command! Ur Unite register
command! Um Unite file_mru
command! Ug Unite grep

" VimCalc
let g:VCalc_WindowPosition = 'bottom'						"ウィンドウは下に起動

" skk.vim
let g:skk_large_jisyo = expand('~/.vim/skk/SKK-JISYO.L')	"辞書
let g:skk_jisyo = expand('~/.vim/skk/skk-jisyo')			"ユーザ辞書
let g:skk_auto_save_jisyo = 1								"ユーザ辞書を聞かずに自動保存

" vim-ref
let g:ref_cache_dir = expand('~/.vim/.vim_ref_cache')

" webdict
" FileTypeがtextならKでwebdictを使う
autocmd FileType text call ref#register_detection('_', 'webdict') 
" infoseek と wikipedia を使う
let g:ref_source_webdict_sites = {
\ 'infoseek_je' : {'url' : 'http://dictionary.infoseek.ne.jp/jeword/%s', 'line' : '11',}, 
\ 'infoseek_ej' : {'url' : 'http://dictionary.infoseek.ne.jp/ejword/%s', 'line' : '11',}, 
\ 'wikipedia'   : {'url' : 'http://ja.wikipedia.org/wiki/%s',},}
" webdict の辞書のデフォルトはinfoseekの英和
let g:ref_source_webdict_sites.default = 'infoseek_ej'			
" テキストブラウザはw3mを使う
let g:ref_source_webdict_cmd = 'w3m -dump %s'

" refe
let g:ref_refe_cmd = expand('~/.vim/ruby_ref/ruby-refm-1.9.2-dynamic-20110729/refe-1_9_2')

" vim-surround
" 追加済みキャラクタ : $ 
" $の設定コマンド :call SurroundRegister('g','$',"$\r$")
" .vimrc に書く必要は無くて、一回呼ぶと良いみたい。

" w3m.vim
autocmd FileType w3m call ref#register_detection('_', 'webdict') 	" K でrefでwebdict
autocmd FileType w3m set nonumber

" }}}

" color settings {{{

highlight Pmenu     ctermbg = grey
highlight PmenuSel  ctermbg = darkcyan
highlight PMenuSbar ctermbg = grey

" }}}
