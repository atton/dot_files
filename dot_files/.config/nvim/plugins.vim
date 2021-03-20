" {{{ dein settings
" {{{ dein initialize
let s:plugins_path = expand('~/.config/nvim/')
let s:dein_path    = s:plugins_path . 'dein'
if has('vim_starting')
    let &runtimepath = s:dein_path . '/repos/github.com/Shougo/dein.vim,' . &runtimepath
    let $NVIM_RPLUGIN_MANIFEST = s:plugins_path . 'rplugin.vim'
endif
" }}}
" {{{ provider initializations for reduce launch time
let g:python3_host_prog = exepath('python3')
let g:ruby_host_prog    = 'neovim-ruby-host'
" }}}

if dein#load_state(s:dein_path)
    call dein#begin(s:dein_path)

    " dein
    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim', {'lazy': 1, 'on_cmd': 'Dein'})

    " completions
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neco-syntax')
    call dein#add('ujihisa/neco-look', {'lazy': 1, 'on_ft': 'text'})

    " extension
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neomru.vim')
    call dein#add('kana/vim-textobj-user')
    call dein#add('tpope/vim-surround')
    call dein#add('tyru/eskk.vim')
    call dein#add('atton/gundo.vim',      {'lazy': 1, 'on_cmd': 'GundoToggle'})
    call dein#add('fedorenchik/VimCalc3', {'lazy': 1, 'on_cmd': 'Calc'})

    " utility
    call dein#add('Konfekt/FastFold')
    call dein#add('rhysd/clever-f.vim')
    call dein#add('tpope/vim-rails')
    call dein#add('tpope/vim-rbenv')
    call dein#add('tyru/open-browser.vim.git')
    call dein#add('h1mesuke/vim-alignta',   {'lazy': 1, 'on_cmd': ['Alignta', 'Align']})
    call dein#add('slim-template/vim-slim', {'lazy': 1, 'on_ft': 'slim'})
    call dein#add('tpope/vim-markdown',     {'lazy': 1, 'on_ft': 'markdown'})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    echomsg 'Uninstalled plugin detected. Please execute `:call dein#install()`'
    finish
endif

" }}}

" plugins settings

" {{{ deoplete

if has('python3')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#data_directory    = s:plugins_path . 'deoplete'
    let s:keyword_patterns = {}
    let s:keyword_patterns['_']    = '[a-zA-Z_]\k*'
    let s:keyword_patterns['ruby'] = '[a-zA-Z_@]\w*[!?]?'
    let s:keyword_patterns['text'] = '[0-9a-zA-Z][0-9a-zA-Z_.-]*'
    let s:keyword_patterns['zsh']  = '[a-zA-Z_][a-zA-Z_-]*'
    call deoplete#custom#option('keyword_patterns', s:keyword_patterns)
    call deoplete#custom#option('sources', {'denite-filter': '_'})  " Disable completions in denite-filter
endif

" }}}

" {{{ neosnippet

" snippet mapping : ^k
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" My snnipets
let g:neosnippet#snippets_directory = s:plugins_path . 'snippets'
let g:neosnippet#data_directory     = s:plugins_path . 'neosnippet'

" }}}

" {{{ Denite

call denite#custom#option('_', 'start_filter', v:true) " Always start at denite-filter
call denite#custom#source('_', 'matchers', ['matcher/substring', 'matcher/fuzzy'])

function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Tab> denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> <C-g> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-l> denite#do_map('redraw')
  nnoremap <silent><buffer><expr> i     denite#do_map('open_filter_buffer')
endfunction
autocmd! FileType denite call s:denite_my_settings()

function! s:denite_filter_my_settings() abort
  imap     <silent><buffer>       <C-g> <Plug>(denite_filter_quit)
  nmap     <silent><buffer>       <C-g> <Plug>(denite_filter_quit)
  imap     <silent><buffer>       <C-l> <Plug>(denite_filter_update)
  nmap     <silent><buffer>       <C-l> <Plug>(denite_filter_update)
  imap     <silent><buffer><expr> <CR>  denite#do_map('do_action')
  nmap     <silent><buffer><expr> <CR>  denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-n> denite#increment_parent_cursor(1)
  inoremap <silent><buffer><expr> <C-p> denite#increment_parent_cursor(-1)
  inoremap <silent><buffer><expr> <Tab> denite#do_map('choose_action')
endfunction
autocmd! FileType denite-filter call s:denite_filter_my_settings()

call denite#custom#var('grep', 'default_opts',
            \ ['--exclude-dir=tmp', '--exclude-dir=log', '-iRHn'])

function! s:denite_grep_by_selected_word_in_current_dir()
    try
        let s:register_save = @a
        normal! gv"ay
        execute 'Denite grep:.::' . @a
    finally
        let @a = s:register_save
    endtry
endfunction

command! -nargs=0 -range DeniteGrepBySelectedWord call s:denite_grep_by_selected_word_in_current_dir()


" Shortcut Mappings
nnoremap <Leader>b :<C-u> Denite buffer<CR>
nnoremap <Leader>f :<C-u> Denite file/rec <CR>
nnoremap <Leader>r :<C-u> Denite register<CR>
nnoremap <Leader>m :<C-u> Denite file_mru<CR>
nnoremap <Leader>g :Denite grep:. <CR>
nnoremap <Leader><Leader> :<C-u> Denite menu:commands<CR>

vnoremap <Leader>k :DeniteGrepBySelectedWord<CR>

" {{{ Denite : neomru

let g:neomru#file_mru_path      = s:plugins_path . 'neomru/file'
let g:neomru#directory_mru_path = s:plugins_path . 'neomru/directory'

" }}}

" {{{ Define denite source 'menu:commands' for shortcuts

let s:denite_commands             = {}
let s:denite_commands.description = 'command shortcuts'

" commands
let s:denite_commands.command_candidates = [
\ ['EditGlobalGitConfig', 'edit ~/.config/git/config'],
\ ['EditGlobalGitIgnore', 'edit ~/.config/git/ignore'],
\ ['EditVimrc',           'edit ~/.config/nvim/init.vim'],
\ ['EditVimrcPlugins',    'edit ~/.config/nvim/plugins.vim'],
\ ['EditZProfile',        'edit ~/.zprofile'],
\ ['EditZProfileLocal',   'edit ~/.config/zsh/zprofile.local'],
\ ['FixSkkDictionary',    'FixSkkDictionary'],
\ ['FormalizePryLogs',    'FormalizePryLogs'],
\ ['GetTitleFromURL',     'GetTitleFromCurrentLineURL'],
\ ['GitCommitTodayNote',  'GitCommitTodayNote'],
\ ['InsertTimeStamps',    'InsertTimeStampsFromUndoHistory'],
\ ['LoadLazyPlugins',     'call dein#source()'],
\ ['PluginUpdate',        'call dein#update()'],
\ ['RecacheRuntimepath',  'call dein#recache_runtimepath()'],
\ ['ReloadVimrc',         'ReloadVimrc'],
\ ]

call denite#custom#var('menu', 'menus', {'commands': s:denite_commands})

" }}}

" }}}

" {{{ VimCalc3

let g:VCalc_Win_Size       = 5
let g:VCalc_WindowPosition = 'bottom'

" }}}

" {{{ eskk.vim

let g:eskk#directory        = expand('~/.config/nvim/eskk')
let g:eskk#dictionary       = {'path': expand('~/.config/nvim/eskk/skk-jisyo'), 'sorted': 0, 'encoding': 'utf-8'}
let g:eskk#large_dictionary = {'path': expand('~/.config/nvim/eskk/SKK-JISYO.L'), 'sorted': 1, 'encoding': 'euc-jp',}
imap <C-J> <Plug>(eskk:enable)
cmap <C-J> <Plug>(eskk:enable)
lmap <C-J> <Plug>(eskk:enable)

" }}}

" {{{ gundo.vim

let g:gundo_prefer_python3 = 1
nnoremap U :GundoToggle<CR>

" }}}

" {{{ vim-surround

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

" {{{ alignta

let g:alignta_default_arguments = " = "
vnoremap <Leader>= :Alignta = <CR>
vnoremap <Leader>: :Alignta : <CR>

" }}}

" {{{ open-browser

" open file using 'split' command
let g:openbrowser_open_vim_command = 'split'

" open URL
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

" }}}

" {{{ clever-f

let g:clever_f_use_migemo = 1

" compatible default keys
let g:clever_f_across_no_line = 1
nmap ; <Plug>(clever-f-repeat-forward)
nmap , <Plug>(clever-f-repeat-back)

" }}}
