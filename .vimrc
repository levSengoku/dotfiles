"Vim7.4から$HOME/.vimrcが$HOME/.vim/vimrcに配置変更
"vi互換にしない VimがVimとして動作する
"但しvimrcがあるとVimは自動的にcompatibleオプションがoffになる
set nocompatible

filetype plugin off
filetype indent off

"pathの追加
"初期化 引数pluginをinstallする基準となるpath
if has('vim_starting')
  set runtimepath+=~/projects/dotfiles/.vim/neobundle.vim
  call neobundle#rc(expand('~/projects/dotfiles/.vim/.bundle/'))
endif

NeoBundle 'Shougo/echodoc.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/unite-ssh.git'
NeoBundle 'Shougo/unite-outline.git'
NeoBundle 'Shougo/vimproc.git'
NeoBundle 'Shougo/vim-vcs.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vinarise.git'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets.vim'
NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'c9s/perlomni.vim'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'heavenshell/unite-zf.git'
NeoBundle 'honza/vim-snippets'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'itchyny/Calendar.vim'
"NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jnwhiteh/vim-golang'
"NeoBundle 'kana/vim-smartinput'
NeoBundle 'kannokanno/unite-todo.git'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'mattn/emmet-vim'
"NeoBundle 'mattn/calendar-vim'
NeoBundle 'mattn/perlvalidate-vim.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'moznion/unite-git-conflict.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'petdance/vim-perl'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'shawncplus/php.vim'
"NeoBundle 'snipMate'
NeoBundle 'spolu/dwm.vim'
NeoBundle 't9md/vim-unite-ack.git'
NeoBundle 'taichouchou2/html5.vim'
"NeoBundle 'taichouchou2/surround.vim'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'taka84u9/vim-ref-ri'
NeoBundle 'taka84u9/unite-git'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
"NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-perl/vim-perl'
"NeoBundle 'vim-scripts/Yankring.vim'
NeoBundle 'vim-scripts/tagbar-phpctags', {
  \  'build': {
  \    'others': 'chmod +x bin/phpctags',
  \  },
  \}
NeoBundle 'vim-scripts/Pydiction.git'

filetype on
filetype plugin on
filetype indent on

"font
set encoding=utf-8
set fileencoding=utf-8
set ambiwidth=double

"popupの背景色
hi Pmenu      ctermbg=4
hi PmenuSel   ctermbg=3
hi PmenuSbar  ctermbg=3
hi PmenuThumb ctermfg=3

"unite.vimの設定
let g:unite_enable_start_insert=0
let g:unite_enable_split_vertically=0
let g:unite_winwidth=25

"<Nop>は空マップ(:help <nop>で確認)
nnoremap [unite] <Nop>
nmap     <Leader>u [unite]
autocmd  FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
autocmd  FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
nnoremap [unite]u :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> ,vr :UniteResume<CR>

"Unite設定
let g:unite_source_file_mru_filename_format = ''
noremap zp :Unite buffer_tab file_mru<CR>
noremap zn :UniteWithBufferDir -buffer-name=files file file/new<CR>
noremap zf :Unite file<CR>

"vimshell
nnoremap <silent> vs :<C-u>VimShell<CR>
nnoremap <silent> vp :<C-u>VimShellPop<CR>

augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap  <buffer> q <Plug>(vimfiler_exit)
  nmap  <buffer> ! <Plug>(vimfiler_hide)
endfunction

"補完ウィンドウの設定
set completeopt=menuone

"neocomplchacheの設定
"disable AutoComplPop
let g:acp_enableAtStartup=0

"use neocomplcache
let g:neocomplcache_enable_at_startup=1

"set minimum syntax keyword length
let g:neocomplcache_min_syntax_length=3
let g:neocomplcache_lock_buffer_name_pattern='\*ku\*'
let g:neocomplcache_enable_ignore_case=1

"use smartinput
"call smartinput_endwise#define_default_rules()

"use smartcase
let g:neocomplcache_enable_smart_case=1

"use camel case completion
let g:neocomplcache_enable_camel_case_completion=1

"use underbar completion
let g:neocomplcache_enable_underbar_completion=1

"select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"close with <CR>
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

"Plugin key_mappings
"imap <C-k><Plug>(neosnippet_expand_or_jump)
"smap <C-k><Plug>(neosnippet_expand_or_jump)
"xmap <C-k><Plug>(neosnippet_expand_target)

let g:neocomplcache_ctags_arguments_list={ 'perl' : '-R -h ".pm"' }

"setting markdown filetype
autocmd BufNewFile,BufRead *.md set filetype=markdown
"Enable omni completion.
autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php setlocal omnifunc=phpcomplete#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 omnifunc=rubycomplete#Complete

"vim-ref用のpathを設定する
let g:ref_phpmanual_path=$HOME.'/projects/dotfiles/.vim/dict/php-chunked-xhtml'
let g:neocomplcache_snippets_disable_runtime_snippets=1
let g:neocomplcache_snippets_dir="~/projects/dotfiles/.vim/snippets"
let g:neocomplcache_dictionary_filetype_lists={'default': '', 'perl': $HOME . '/projects/dotfiles/.vim/dict/perl.dict'}

"Python用のdic
let g:neocomplcache_dictionary_filetype_lists={'default': '', 'python': $HOME . '/projects/dotfiles/.vim/Pydiction/complete_dict', 'vimshell': $HOME . '/projects/dotfiles/.VimShell/command_history'}

"define keyword
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns={}
endif
let g:neocomplcache_keyword_patterns['default']='\h\w*'
"let g:neocomplcache_delimiter_patterns['php']=['->', '::', '\']

"file type
if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists={}
endif

"snippetの設定
"inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
"imap <expr><C-k> pumvisible() ? "\<C-n>" :neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-k>"
"smap <expr><C-k> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-k>"

"for snippet_complete marker
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"enable snipMate compatibility feature
let g:neosnippet#enable_snipmate_compatibility=1

"tell neosnippet about the otherr snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"unite-grepのバックエンドをagに切り替える
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_max_candidates=200
vnoremap /g y:Unite grep::-iHRn:<C-r>=escape(@",'\\.*$^[]')<CR><CR>

let file_name=expand("%:p")
if has('vim_starting') && file_name==""
  autocmd VimEnter * call ExecuteNERDTree()
endif
"カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
  b:nerdstatus=1
  b:nerdstatus=2

  if!exists('g:nerdstatus')
    execute'NERDTree./'
    letg:windowWidth=winwidth(winnr())
    letg:nerdtreebuf=bufnr('')
    letg:nerdstatus=1
  elseif g:nerdstatus==1
    execute'wincmdt'
    execute 'vertical resize' 0
    execute 'wincmd p'
    let g:nerdstatus=2
  elseif g:nerdstatus==2
    execute 'wincmd t'
    execute 'vertical resize' g:windowWidth
    let g:nerdstatus=1
  endif
endfunction
noremap <c-e> :<c-u>:call ExecuteNERDTree()<CR>

"quickrunの設定(\+rで実行)
nmap <Leader>r <plug>(quickrun)

"easy-motionのprefixを指定
let g:EasyMotion_leader_key='<SPACE>e'

"yankring
"let g:yankring_max_history=30

"spolu/dwm.vim(ウィンド型タイルマネージャ)の設定
nnoremap <C-j> <C-w>w
nnoremap <C-k> <C-w>W
nmap <M-r> <Plug>DWMRotateCounterclockwise
nmap <M-t> <Plug>DWMRotateClockwise
nmap <C-n> <Plug>DWMNew
nmap <C-n> <Plug>DWMClose
nmap <C-@> <Plug>DWMFocus
nmap <C-Space> <Plug>DWMFocus
nmap <C-l> <Plug>DWMGrowMaster
nmap <C-h> <Plug>DWMShrinkMaster

" use Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  "let g:ctrlp_use_caching=0
endif

let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-y>'
let g:user_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \  'lang': 'ja',
  \  'html': {
  \    'filters': 'html',
  \  },
  \  'css': {
  \    'filters': 'fc',
  \  },
  \  'php': {
  \    'extends': 'html',
  \    'filters': 'html',
  \  },
  \}
augroup EmmetVim
  autocmd!
  autocmd FileType * let g:user_emmet_settings.indentation = '  '[:&tabstop]
augroup END

"カーソル下のURLをブラウザで開く
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

"ファイル変更があった場合、自動再読み込み
set autoread

"コマンドラインモードにおける補完機能を有効にする
set wildmenu wildmode=list:full

"Ctrl+nでファイルを切り替える 切り替える前にファイルを保存する
"nmap :update:bn
"imap :update:bn
"vmap :update:bn
"cmap :update:bn

"常にステータスラインを表示する
set laststatus=2
set statusline=\ \ %F%r\ [%{&fenc}][%{&ff}]\ %{fugitive#statusline()}%=\ row:\ %l\ col:\ %c\ %5p%%\ \ \ \ \ 

"シンタックスハイライトを有効にする
syntax on
syntax enable
"set background=dark
"let g:sloarized_termtrans=1
"let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme molokai

"if &background ==# 'dark'
"  colorscheme solarized
"endif

"cursorlineを表示する
"set cursorline

"カラー設定を行う
"highlight Normal ctermbg=none ctermfg=white
highlight StatusLine term=none cterm=none ctermfg=0 ctermbg=255
"highlight CursorLine term=none cterm=none ctermfg=none  ctermbg=grey

"日本語入力時にカーソルの色を変える
if has('multi_byte_ime')||('xie')
  highlight CursorIM guibg=Purple guifg=NONE
endif

"新しい行のインデントを現在行と同じにする
set autoindent
"set smartindent

"insert_mode時、status_lineの色を変更
let g:hi_insert='highlight StatusLine ctermfg=0 ctermbg=190 cterm=none'
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

if has('syntax')
  augroup filetypedetect
    au BufNewFile,BufRead *.psgi   setf perl
    au BufNewFile,BufRead *.t      setf perl
    au BufNewFile,BufRead *.tt     setf tt2html
    au BufNewFile,BufRead *.tt2    setf tt2html
    au BufNewFile,BufRead cpanfile setf perl
  augroup END
endif

nnoremap ,pt <Esc>:%! perltidy -se<CR>
vnoremap ,pt <Esc>:'<,'! perltidy -se<CR>

let s:slhlcmd=''
function! s:StatusLine(mode)
if a:mode == 'Enter'
  silent! let s:slhlcmd='highlight ' . s:GetHighlight('StatusLine')
  silent exec g:hi_insert
else
  highlight clear StatusLine
  silent exec s:slhlcmd
endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl=substitute(hl, '[\r\n]', '', 'g')
  let hl=substitute(hl, 'xxx', '', '')
return hl
endfunction

"全角スペースを表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

augroup Python_Coding
  au FileType python call s:python_setting(
augroup END
function! s:python_setting()
  setl autoindent
  setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,cl
  set  expandtab tabstop=4 shiftwidth=4 softtabstop=4
  setl textwidth=80
  setl colorcolumn=80
  setl foldmethod=indent
  setl foldlevel=99
endfunction

if $GOROOT != ''
  set runtimepath+=$GOROOT/misc/vim
  let g:syntastic_go_checkers=['go', 'golint', 'govet']
endif

augroup Go
  autocmd!
  autocmd BufWritePre *.go Fmt
augroup END

augroup CoffeeScript
  autocmd!
  autocmd FileType coffee cnorepam <buffer> cf CoffeeCompile watch vert<CR>
augroup END

" 構文情報とハイライト情報を取得する(:Syntaxinfo)
" http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name    = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg   = synIDattr(a:synid, "fg", "gui")
  let guibg   = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"バックアップファイルを作るディレクトリ
set backupdir=$HOME/vim_backup

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
"set browsedir=buffer 

"クリップボードを連携
set clipboard=unnamed,autoselect

"xtermとscreen対応
set ttymouse=xterm2

"スワップファイル用のディレクトリ
"set directory=$HOME/vimbackup

"行頭の余白内でTabを打ち込むと'shiftwidth'の数だけインデントする
set smarttab

"タブの代わりに空白文字を挿入する
set expandtab

"ファイル内の <Tab> が対応する空白の数
set tabstop=2

"シフト移動幅
set shiftwidth=2

"変更中のファイルでも、保存しないで他のファイルを表示
"set hidden

"書き込み権限のないファイルの場合
cmap w!! w !sudo tee > /dev/null %

"インクリメンタルサーチを行う
set incsearch

"該当箇所の背景色を変化させる
set hlsearch

"サーチハイライトをESC２回で消す
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"listで表示される文字のフォーマットを指定する
"set listchars=tab:>\

"行番号を表示する
"set relativenumber
set number

"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch matchtime=1

"検索時に大文字を含んでいたら大/小を区別
set ignorecase
set smartcase

"モードを非表示に
set noshowmode

"特定のディレクトリ以下だけの設定
"autocmd BufNewfile,BufRead /path/to/project/*.php set noexpandtab

"コマンドラインの高さ
set cmdheight=2

"タイトルをウィンドウ枠に表示
set title

"ルーラを表示
set ruler

"入力中のコマンドを表示
set showcmd

"TAB,行末の半角スペースを可視化
"set list

"splitの設定
set splitright
set diffopt=vertical

"vimrcの簡単起動
"nmap rc [vimrc]
nnoremap <silent> [vimrc]  :<C-u>e      $MYVIMRC<CR>
nnoremap <silent> [vimrc]v :<C-u>vs     $MYVIMRC<CR>
nnoremap <silent> [vimrc]x :<C-u>sp     $MYVIMRC<CR>
nnoremap <silent> [vimrc]v :<C-u>source $MYVIMRC<CR>

"vimrcを自動更新
augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END  

"jkを加速する
let g:accelerated_jk_acceleration_table = [10,5,3]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"ESCキーの待ちをなくす
let &t_SI .= "\e[?7727h"
let &t_EI .= "\e[?7727l"
inoremap <special> <Esc>O[ <Esc>

"無限undo
"if has('persistent_undo')
"  set undodir=~/.vim/undo
"  set undofile
"endif

"alignで選択した範囲を整列
vnoremap <silent><C-l> :Alignta <<0:1 =>/1<cr>
vnoremap <silent><C-k> :Alignta <<-1:1 =/1<cr>

"カーソルを自動的に括弧の中へ
imap () ()<Left>
imap {} {}<Left>
imap [] []<Left>
imap <> <><Left>
imap '' ''<Left>
imap "" ""<Left>
imap `` ``<Left>
imap ** **<Left>
imap %% %%<Left>
imap ?? ??<Left>
"imap // //<Left>
imap /// ///<Left>
imap \|\| \|\|<Left>

"gfでカーソル下のファイル名を新しいタブで開く
nnoremap gf :tab <cfile><CR>
vnoremap gf :tab <cfile><CR>

"検索語が画面中央に来るように
nmap n nzz
nmap N Nzz

" over.vim 
" over.vimの起動
nnoremap <silent> <Leader>m :OverCommandLine<CR>
" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

" :makeや:grepをした際に自動的にquickfixが開くようにする
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd if len(getqflist()) != 0 | cw | endif

"ctagsのファイルをカレントディレクトリから検索して上位にあるもの読み込む
if has('path_extra')
  set tags+=tags;
endif
map <Leader>ct :!ctags -R .<CR>

"vimファイルに関して{と}による折りたたみ設定をする
au FileType vim setlocal foldmethod=marker

" :makeでPHP構文チェック
au FileType php setlocal makeprg=php\ -l\ %
au FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" HTMLもハイライト
let php_htmlInStrings=1

" 文字列の中のSQLをハイライト
let php_sql_query=1

" Baselibメソッドのハイライト
let php_baselib=1

" <? を無効にする(ハイライト除外にする)
let php_noShortTags=1

" ] や ) の対応エラーをハイライト
let php_parent_error_close=1
let php_parent_error_open=1

" li, pをblock tagとして扱う
let g:html_inden_tags='li\|p'

" JSのfunctionλにする
" http://labs.timedia.co.jp/2011/04/javascript-function-lambda-vim.html
setlocal conceallevel=2
syntax keyword javaScriptLambda function conceal cchar=λ
highlight clear Conceal
highlight link Conceal Identifier
highlight link javaScriptLambda Identifier
