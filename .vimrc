" Vundle の設定
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
Bundle 'neco-look'
Bundle 'matchit.zip'
Bundle 'tyru/skk.vim'
Bundle 'taku-o/vim-toggle'
"Bundle 'surround.vim'
"Bundle 'autodate.vim'

filetype plugin indent on			"FileTypeを再適用


" 各種設定
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
set backspace=indent,eol,start		"<BS>で改行文字等を削除できるように
set ambiwidth=double				"Ambiguous文字の幅を二倍に
set pumheight=7						"ポップアップメニューに表示する
set foldmethod=marker				"折り畳みはmarkerで。
let loaded_matchparen = 1			"対応する括弧のハイライトを表示しない

"エンコーディングはUTF-8
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ascii,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
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
"インサートモード時に<C-f>でカーソルを右へ移動
inoremap <unique><C-f> <Right>
"インサートモード時に<C-f>でカーソルを左へ移動
inoremap <unique><C-b> <Left>
"QuickRun用のショートカット
nmap <C-k> <Plug>(quickrun)
"C^lで検索ハイライトを消す
nnoremap <C-l> :nohlsearch<CR><C-l>
"texの時 n_^k でvimshellでtexpdfを実行するようにする(vimshellが開いている時のみ)
autocmd FileType tex nnoremap <C-K> :VimShellSendString texpdf<CR>

" command mode をzsh likeに
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-f> <RIGHT>
cnoremap <C-b> <LEFT>
cnoremap <C-d> <DEL>


"undoのポイントを追加するところ
inoremap <CR> <C-g>u<CR>
inoremap <C-@> <C-g>u<C-@>


"ShortCutCommand
"VimShell用のショートカット
command! Vsh VimShellTab


" Omni補完用の設定
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP					"PHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete							"C
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags				"HTML
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS		"JavaScript
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete					"ruby


" Ruby 用の設定
autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab

"Undo履歴を保存する
if has('persistent_undo')
	set undodir=~/.vim/undo_history							"保存するディレクトリ
	set undofile
endif

"template
autocmd BufNewFile *.rb 0r ~/.vim/templates/ruby.rb			"ruby
autocmd BufNewFile *.php 0r ~/.vim/templates/php.php		"php


"plugins


" quickrun
let g:quickrun_config={'*': {'split': ''}}					"起動時は横分割(上下に)

" neocomplcache
let g:neocomplcache_enable_at_startup = 1					" 起動時に有効化
let g:neocomplcache_enable_underbar_completion = 1			" _の補完を有効化
let g:neocomplcache_temporary_dir = expand('~/.vim/.neocon')

" neocomplcacheのスニペットを<C-k> にマッピング
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" vimshell
let g:vimshell_interactive_update_time = 25
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = ''
let g:vimshell_right_prompt = 'getcwd()'
autocmd FileType vimshell setlocal nonumber

" unite
" <c-k>でyank
autocmd FileType unite nnoremap <buffer><expr> <c-k> unite#smart_map('<c-k>',unite#do_action('yank'))
let g:unite_update_time = 25
command! Ub Unite buffer
command! Uf Unite file
command! Ur Unite register
command! Um Unite file_mru


" VimCalc
let g:VCalc_WindowPosition = 'bottom'						"ウィンドウは下に起動

" skk.vim
let g:skk_large_jisyo = expand('~/.vim/skk/SKK-JISYO.L')	"辞書
let g:skk_jisyo = expand('~/.vim/skk/skk-jisyo')			"ユーザ辞書
let g:skk_auto_save_jisyo = 1								"ユーザ辞書を聞かずに自動保存

" vim-ref
autocmd FileType text call ref#register_detection('_', 'alc')	"textならKでalcを使う
"alc
let g:ref_alc_cmd = 'w3m -dump %s'								"w3mを使う
let g:ref_alc_start_linenumber = 39								"表示開始位置
"refe
let g:ref_refe_cmd = expand('~/.vim/ruby_ref/ruby-refm-1.9.2-dynamic-20110729/refe-1_9_2')


" 色の設定
highlight Pmenu ctermbg=grey
highlight PmenuSel ctermbg=darkcyan
highlight PMenuSbar ctermbg=grey
