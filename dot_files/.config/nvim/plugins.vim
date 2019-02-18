" {{{ setup dein
"    plugins management plugin : dein.vim
"      $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
"      $ sh ./installer.sh ~/.config/nvim
"      :call dein#install()
" }}}
"
" {{{ setup eskk
"   $ mkdir -p ~/.config/nvim/eskk
"   $ curl https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L > ~/.config/nvim/eskk/SKK-JISYO.L
" }}}

" dein settings {{{
" dein initialize {{{
let s:plugins_path = expand('~/.config/nvim/')
let s:dein_path    = s:plugins_path . 'repos/github.com/Shougo/dein.vim'
if has('vim_starting')
    execute 'set runtimepath+=' . s:dein_path
endif
" }}}

" list up plugins

if dein#load_state(s:dein_path)
    call dein#begin(s:plugins_path)
    " dein
    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim', {'lazy':1, 'on_cmd': 'Dein'})

    " completions
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neco-syntax')
    call dein#add('ujihisa/neco-look', {'lazy': 1, 'on_ft': 'text'})

    " quickrun and watchdogs
    call dein#add('thinca/vim-quickrun')
    call dein#add('osyo-manga/vim-watchdogs')
    call dein#add('osyo-manga/shabadou.vim')

    " extension
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('thinca/vim-ref')
    call dein#add('tyru/eskk.vim')
    call dein#add('atton/gundo.vim',     {'lazy':1, 'on_cmd': 'GundoToggle'})
    call dein#add('gregsexton/VimCalc',  {'lazy':1, 'on_cmd': 'Calc'})

    " utility
    call dein#add('Konfekt/FastFold')
    call dein#add('rhysd/clever-f.vim')
    call dein#add('tyru/open-browser.vim.git')
    call dein#add('osyo-manga/vim-over',  {'lazy':1, 'on_cmd': ['OverCommandLine']})
    call dein#add('h1mesuke/vim-alignta', {'lazy':1, 'on_cmd': ['Alignta', 'Align']})
    call dein#add('atton/a.vim',          {'lazy':1, 'on_ft' : ['c', 'cpp']})

    " text-objects extension
    call dein#add('tpope/vim-surround')
    call dein#add('kana/vim-textobj-user')
    call dein#add('rbonvall/vim-textobj-latex' , {'lazy': 1, 'on_ft': 'tex'})

    " syntax
    call dein#add('tpope/vim-rails')
    call dein#add('dag/vim2hs'                , {'lazy':1 ,'on_ft': 'haskell'})
    call dein#add('sophacles/vim-processing'  , {'lazy':1, 'on_path': '.*\.pde'})
    call dein#add('tpope/vim-markdown'        , {'lazy':1 ,'on_path': ['.*\.md', '.*\.mkd']})
    call dein#add('kchmck/vim-coffee-script'  , {'lazy':1, 'on_ft': 'coffee'})
    call dein#add('vim-scripts/promela.vim'   , {'lazy':1, 'on_ft': 'promela'})
    call dein#add('slim-template/vim-slim'    , {'lazy':1, 'on_path': '.*\.slim'})
    call dein#add('leafgarland/typescript-vim', {'lazy':1, 'on_path': '.*\.ts'})
    call dein#add('ElmCast/elm-vim'           , {'lazy':1, 'on_path': '.*\.elm'})


    " lazy load plugins
    call dein#add('yuratomo/w3m.vim' , {'lazy':1, 'on_cmd': 'W3m'})
    call dein#add('Shougo/vinarise'  , {'lazy':1, 'on_cmd': 'Vinarise'})
    call dein#add('taka84u9/vim-ref-ri')
    call dein#add('ujihisa/ref-hoogle')

    " for debug
    call dein#add('thinca/vim-prettyprint', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" }}}

" plugins settings

" deoplete {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#data_directory    = expand('~/.config/nvim/.deoplete')

" }}}

" neosnippet {{{

" snippet mapping : ^k
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" My snnipets
let g:neosnippet#snippets_directory = expand("~/.config/nvim/snippets")
let g:neosnippet#data_directory     = expand("~/.config/nvim/.neosnippet")

" }}}

" Denite {{{

call denite#custom#option('default', 'cursor_wrap', v:true)

call denite#custom#map('insert', '<C-g>',   '<denite:leave_mode>',            'noremap')
call denite#custom#map('insert', '<C-n>',   '<denite:move_to_next_line>',     'noremap')
call denite#custom#map('insert', '<C-p>',   '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-j>',   '<denite:toggle_select>',         'noremap')
call denite#custom#map('insert', '<Tab>',   '<denite:choose_action>',         'noremap')

call denite#custom#var('file_rec', 'command', [ 'find', '-L', ':directory',
            \ '-path', '*/.*/*', '-prune', '-o',
            \ '-type', 'l', '-print', '-o',
            \ '-type', 'f', '-print'])

call denite#custom#var('grep', 'default_opts',
            \ ['--exclude-dir=tmp', '--exclude-dir=log', '-iRHn'])

function! s:denite_grep_by_selected_word_in_current_dir()
    try
        let s:register_save = @a
        normal! gv"ay
        let s:command = 'Denite grep:.::' . @a
        exec s:command
    finally
        let @a = s:register_save
    endtry
endfunction

command! -nargs=0 -range DeniteGrepBySelectedWord call s:denite_grep_by_selected_word_in_current_dir()


" Shortcut Mappings
nnoremap <Leader>b :<C-u> Denite buffer<CR>
nnoremap <Leader>f :<C-u> Denite file_rec <CR>
nnoremap <Leader>r :<C-u> Denite register<CR>
nnoremap <Leader>m :<C-u> Denite file_mru<CR>
nnoremap <Leader>g :Denite grep:. <CR>
nnoremap <Leader>c :<C-u> Denite menu:commands<CR>
nnoremap <Leader><Leader> :<C-u> Denite menu:commands<CR>

vnoremap <Leader>k :DeniteGrepBySelectedWord<CR>

" commands source. for command shortcut {{{

let s:denite_commands             = {}
let s:denite_commands.description = 'command shortcuts'

" commands
let s:denite_commands.command_candidates = [
\ ['ReloadVimrc'     , 'ReloadVimrc'],
\ ['EditVimrc'       , 'EditVimrc'],
\ ['EditVimrcPlugins', 'EditVimrcPlugins'],
\ ['ToggleLastStatus', 'ToggleLastStatus'],
\ ['ToggleWildIgnore', 'ToggleWildIgnore'],
\ ['PluginUpdate' ,    'Dein update'],
\ ['LoadLazyPlugins' , 'Dein soure'],
\ ['InsertTimeStampsFromUndoHistory' , 'InsertTimeStampsFromUndoHistory'],
\ ]

call denite#custom#var('menu', 'menus', {'commands': s:denite_commands})

" }}}
" }}}

" {{{ Denite : neomru

let g:neomru#file_mru_path      = expand('~/.config/nvim/.neomru/file')
let g:neomru#directory_mru_path = expand('~/.config/nvim/.neomru/directory')

" }}}

" quickrun {{{

" shortcut
nmap <C-k> <Plug>(quickrun)
" disable default mappings
let g:quickrun_no_default_key_mappings = 1

" init default settings
let g:quickrun_config = {'_' : {}}
" horizontal split on quickrun
let g:quickrun_config._['split'] = ''
" move cursor into quickrun buffer
let g:quickrun_config._['outputter/buffer/into']     = 1
" vimproc updatetime
let g:quickrun_config._['runner']                    = 'vimproc'
let g:quickrun_config._['runner/vimproc/updatetime'] = 50

" for scheme : use -i flag (for SICP)
let g:quickrun_config.scheme = {'command' : 'gosh' , 'cmdopt' : '-i' , 'exec' : '%c %o < %s'}
" for processing (need processing-java command and vim-processing plugin)
let g:quickrun_config.processing = {
\     'command': 'processing-java',
\     'exec': '%c --sketch=%s:p:h/ --output=/tmp/processing --run --force'}
" for markdown
let g:quickrun_config.markdown          = {'outputter' : 'browser'}
let g:quickrun_config['markdown.slide'] = {'command' : 'build_tmp_slide.sh',
\                                          'exec' : '%c %s:p:r %s:t:r',
\                                          'outputter' : 'null'}

" for not executable filetype : not execute quickrun
let s:not_executable_filetypes = ['text', 'help', 'quickrun', 'qf', 'ref-refe', 'ref-webdict']
for s:ft in s:not_executable_filetypes
    if !has_key(g:quickrun_config, s:ft)
        let g:quickrun_config[s:ft] = {}
    endif
    let g:quickrun_config[s:ft]['command']   = 'false'
    let g:quickrun_config[s:ft]['outputter'] = 'null'
endfor


" shabadou hooks {{{
" for all : if output is empty, close quickrun buffer and echo message(finished point)
let g:quickrun_config._['hook/close_buffer/enable_empty_data'] = 1
let g:quickrun_config._['hook/echo/enable']                    = 1
let g:quickrun_config._['hook/echo/output_finish']             = 'quickrun finished.'
" for quickfix : close quickfix window
let g:quickrun_config.qf['hook/echo/output_finish']            = 'close quickrun window'
let g:quickrun_config.qf['hook/close_quickfix/enable_exit']    = 1
" }}}
" }}}

" watchdogs {{{

" default settings
let s:watchdogs_config = {}
" for unnammed buffer
let s:watchdogs_config['hook/quickfix_replate_tempname_to_bufnr/enable_exit']   = 1
let s:watchdogs_config['hook/quickfix_replate_tempname_to_bufnr/priority_exit'] = -10

" for LaTeX {{{
let g:quickrun_config['tex/watchdogs_checker'] = {
            \'type' : 'watchdogs_checker/tex' }
let g:quickrun_config['watchdogs_checker/tex'] = {
        \'command' : 'lacheck',
        \'exec' : '%c %s',
        \
        \'quickfix/errorformats' :
            \'%E!\ LaTeX\ %trror:\ %m,'
            \.'%E!\ %m,'
            \.'%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#,'
            \.'%+W%.%#\ at\ lines\ %l--%*\\d,'
            \.'%WLaTeX\ %.%#Warning:\ %m,'
            \.'%Cl.%l\ %m,'
            \.'%+C\ \ %m.,'
            \.'%+C%.%#-%.%#,'
            \.'%+C%.%#[]%.%#,'
            \.'%+C[]%.%#,'
            \.'%+C%.%#%[{}\\]%.%#,'
            \.'%+C<%.%#>%.%#,'
            \.'%C\ \ %m,'
            \.'%-GSee\ the\ LaTeX%m,'
            \.'%-GType\ \ H\ <return>%m,'
            \.'%-G\ ...%.%#,'
            \.'%-G%.%#\ (C)\ %.%#,'
            \.'%-G(see\ the\ transcript%.%#),'
            \.'%-G\\s%#,'
            \.'%+O(%*[^()])%r,'
            \.'%+O%*[^()](%*[^()])%r,'
            \.'%+P(%f%r,'
            \.'%+P\ %\\=(%f%r,'
            \.'%+P%*[^()](%f%r,'
            \.'%+P[%\\d%[^()]%#(%f%r,'
            \.'%+Q)%r,'
            \.'%+Q%*[^()])%r,'
            \.'%+Q[%\\d%*[^()])%r' }
" }}}

" add to quickrun_config
let g:quickrun_config['watchdogs_checker/_']  = s:watchdogs_config
unlet s:watchdogs_config
" watchdogs initialize
call watchdogs#setup(g:quickrun_config)
" shortcut
nnoremap <C-j> :WatchdogsRunSilent<CR>

" }}}

" VimCalc {{{

let g:VCalc_WindowPosition = 'bottom'                       " show buttom

" }}}

" eskk.vim {{{

let g:eskk#directory        = expand('~/.config/nvim/eskk')
let g:eskk#dictionary       = {'path': expand('~/.config/nvim/eskk/skk-jisyo'), 'sorted': 0, 'encoding': 'utf-8'}
let g:eskk#large_dictionary = {'path': expand('~/.config/nvim/eskk/SKK-JISYO.L'), 'sorted': 1, 'encoding': 'euc-jp',}
imap <C-J> <Plug>(eskk:enable)
cmap <C-J> <Plug>(eskk:enable)
lmap <C-J> <Plug>(eskk:enable)

function! s:eskk_cleanup_candidate()
    echo "^[0-9a-z\u3042-\u3093]*\\ \\/[0-9a-z\u3042-\u3093]*\\/$"
endfunction
command! -nargs=0 EskkCleanupCandidate call s:eskk_cleanup_candidate()

" }}}

" vim-ref {{{

let g:ref_cache_dir = expand('~/.vim/.vim_ref_cache')

" webdict
" webdict source use yahoo_dict and infoseek and wikipedia
let g:ref_source_webdict_sites = {
\ 'yahoo_dict'  : {'url' : 'http://dic.search.yahoo.co.jp/search?p=%s',  'line' : '45'},
\ 'infoseek_je' : {'url' : 'http://dictionary.infoseek.ne.jp/jeword/%s', 'line' : '11'},
\ 'infoseek_ej' : {'url' : 'http://dictionary.infoseek.ne.jp/ejword/%s', 'line' : '11'},
\ 'wikipedia'   : {'url' : 'http://ja.wikipedia.org/wiki/%s',},}
" webdict default dictionary is yahoo_dict
let g:ref_source_webdict_sites.default = 'yahoo_dict'
" text browser is w3m
let g:ref_source_webdict_cmd = 'w3m -dump %s'
" if FileType is 'text', use webdict source
call ref#register_detection('text',     'webdict')
call ref#register_detection('markdown', 'webdict')
call ref#register_detection('w3m',      'webdict')

" }}}

" gundo.vim {{{

" UndoTree : U
nnoremap U :GundoToggle<CR>

" }}}

" vim-surround {{{

" manual mapping for eskk.vim (ignore ISurruond)
let g:surround_no_mappings = 1
" diff original mapping : Visual mode surround use 's' (original is 'S')
if has('vim_starting')
    nmap ds  <Plug>Dsurround
    nmap cs  <Plug>Csurround
    nmap ys  <Plug>Ysurround
    nmap yS  <Plug>YSurround
    nmap yss <Plug>Yssurround
    nmap ySs <Plug>YSsurround
    nmap ySS <Plug>YSsurround
    xmap s   <Plug>VSurround
    xmap gs  <Plug>VgSurround
endif

" }}}

" alignta {{{

let g:alignta_default_arguments = " = "
vnoremap <Leader>= :Alignta = <CR>
vnoremap <Leader>: :Alignta : <CR>
vnoremap <Leader>& :Alignta & <CR>

" }}}

" open-browser {{{

let g:netrw_nogx = 1 " disable netrw's gx mapping.

" open URL
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" }}}

" {{{ vim2hs

let g:haskell_conceal = 0   " disable conceal. lambda and function compose

" }}}

" {{{ clever-f

let g:clever_f_use_migemo = 1

" compatible default keys
let g:clever_f_across_no_line = 1
nmap ; <Plug>(clever-f-repeat-forward)
nmap , <Plug>(clever-f-repeat-back)

" }}}

" {{{ elm-vim
let g:elm_setup_keybindings = 0
" }}}

" {{{ w3m.vim
let g:w3m#history#save_file = s:plugins_path . '.vim_w3m_hist'
"
