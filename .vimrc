" neobundle Settings {{{
filetype off					
" neobundle initialize {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
" }}}

" set use plugins
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'gregsexton/VimCalc'
NeoBundle 'ujihisa/neco-ruby'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tyru/skk.vim'
NeoBundle 'taku-o/vim-toggle'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'kana/vim-surround'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'dag/vim2hs'
NeoBundle 'neco-look'
NeoBundle 'matchit.zip'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'

" auto make vimproc
NeoBundle 'Shougo/vimproc', {
			\ 'build' : {
			\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'unix' : 'make -f make_unix.mak',
			\    },
			\ }

" lazy load plugins
NeoBundleLazy 'yuratomo/w3m.vim'
NeoBundleLazy 'Shougo/vinarise'
NeoBundleLazy 'taka84u9/vim-ref-ri'

" check not installed plugin {{{
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
				\ string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
	"finish
endif
" }}}

filetype plugin indent on			" enable FileType
" }}}

" settings {{{
syntax on                   		" シンタックスをオンに
set nocompatible					" viとの互換を切る
set hidden							" バッファを保存しなくても他のバッファを表示できるように
set showmatch						" 対応する括弧を表示
set showcmd							" 入力中のコマンドを表示
set tabstop=4						" タブ１つはスペース４つ分
set number							" 行番号表示
set autoindent						" オートインデント
set shiftwidth=4					" オートインデント時の空白数
set splitbelow						" 上下に新しいウィンドウを開いたときは下に
set splitright						" 左右に新しいウィンドウを開いたときは右に
set ignorecase						" 検索時、小文字のみなら、小文字大文字を区別しない
set smartcase						" 検索時、大文字があるときは、小文字大文字を区別する
set wildmenu						" コマンドラインモード時に補完を有効化
set hlsearch						" 検索したワードをハイライト表示
set vb t_vb=						" ベルは鳴らさない
set backspace=indent,eol,start		" <BS>で改行文字等を削除できるように
set ambiwidth=double				" Ambiguous文字の幅を二倍に。全角記号対策
set pumheight=7						" ポップアップメニューのアイテム数は7
set foldmethod=marker				" 折り畳みはmarkerで
let loaded_matchparen = 1			" 対応する括弧のハイライトを表示しない
set nrformats-=octal				" ^a^xの時に8進数(先頭に0がつく場合)は無視
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

" commands {{{
command! ReloadVimrc source $MYVIMRC
command! EditVimrc edit $MYVIMRC
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
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

" plugins {{{


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

augroup vimshell
	autocmd!
	autocmd FileType vimshell setlocal nonumber
augroup END
" command for shortcut
command! Vsh VimShellTab


" Unite
let g:unite_update_time = 10
let g:unite_data_directory = expand('~/.vim/.unite')
command! Ub Unite buffer
command! Uf Unite file
command! Ur Unite register
command! Um Unite file_mru
command! Ug Unite grep
command! Uc Unite menu:commands
" commands source. for command shortcut {{{
 
" command map
let s:commands = {}
function s:commands.map(key, value)
	return { 'word': a:key, 'kind': 'command', 'action__command': a:value}
endfunction

" commands
let s:commands.candidates = {
\ 'NeoBundleUpdate': 'NeoBundleUpdate',
\ 'NeoBundleSource': 'NeoBundleSource',
\ 'ReloadVimrc'    : 'ReloadVimrc',
\ 'EditVimrc'      : 'EditVimrc',
\ }

" add unite
let g:unite_source_menu_menus = {'commands': deepcopy(s:commands)}

unlet s:commands
" }}}


" quickrun
" ショートカット
nmap <C-k> <Plug>(quickrun)
" 起動時は縦分割
let g:quickrun_config = {'*': {'split': ''}}
" scheme を quickrun 
let g:quickrun_config.scheme = {'command' : 'gosh' , 'cmdopt' : '-i' , 'exec' : '%c %o < %s'}


" watchdogs
" quickfix にデータがある場合に quickfix ウィンドウを開く
let g:quickrun_config['watchdogs_checker/_'] = { 'hook/copen/enable_exist_data' : 1}
" errorformat for ruby
let g:quickrun_config['watchdogs_checker/ruby'] = { 'outputter/quickfix/errorformat' : '\%+E%f:%l:\ parse\ error, \%W%f:%l:\ warning:\ %m, \%E%f:%l:in\ %*[^:]:\ %m, \%E%f:%l:\ %m, \%-C%\tfrom\ %f:%l:in\ %.%#, \%-Z%\tfrom\ %f:%l, \%-Z%p^, \%-G%.%#'}
" 初期化
call watchdogs#setup(g:quickrun_config)

" VimCalc
let g:VCalc_WindowPosition = 'bottom'						"ウィンドウは下に起動


" skk.vim
let g:skk_large_jisyo = expand('~/.vim/skk/SKK-JISYO.L')	"辞書
let g:skk_jisyo = expand('~/.vim/skk/skk-jisyo')			"ユーザ辞書
let g:skk_auto_save_jisyo = 1								"ユーザ辞書を聞かずに自動保存


" vim-ref
let g:ref_cache_dir = expand('~/.vim/.vim_ref_cache')

" webdict
augroup ref
" FileTypeがtextならKでwebdictを使う
	autocmd!
	autocmd FileType text call ref#register_detection('_', 'webdict') 
augroup END
" yahoo_dict と infoseek と wikipedia を使う
let g:ref_source_webdict_sites = {
\ 'yahoo_dict' : {'url' : 'http://dic.search.yahoo.co.jp/search?p=%s', 'line' : '47'},
\ 'infoseek_je' : {'url' : 'http://dictionary.infoseek.ne.jp/jeword/%s', 'line' : '11',}, 
\ 'infoseek_ej' : {'url' : 'http://dictionary.infoseek.ne.jp/ejword/%s', 'line' : '11',}, 
\ 'wikipedia'   : {'url' : 'http://ja.wikipedia.org/wiki/%s',},}
" webdict の辞書のデフォルトはyahoo_dict
let g:ref_source_webdict_sites.default = 'yahoo_dict'			
" テキストブラウザはw3mを使う
let g:ref_source_webdict_cmd = 'w3m -dump %s'

" refe
let g:ref_refe_cmd = expand(' ~/.vim/ruby_ref/ruby-refm-1.9.3-dynamic-20120829/refe-1_9_3 ')


" gundo.vim
" UでUndoTree
nnoremap U :GundoToggle<CR>


" vim-surround
" 追加済みキャラクタ : $ 
" $の設定コマンド :call SurroundRegister('g','$',"$\r$")
" .vimrc に書く必要は無くて、一回呼ぶと良いみたい？


" w3m.vim
augroup w3m
	autocmd! 	
	" K でrefでwebdict
	autocmd FileType w3m call ref#register_detection('_', 'webdict')
	autocmd FileType w3m set nonumber
augroup END

" }}}
