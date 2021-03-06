scriptencoding utf-8

" groupの初期化
augroup vimrc
  autocmd!
augroup END

" filetype関連をoffにする
filetype off
filetype plugin indent off

" エンコード
set fileencoding=utf-8               " 書き込む際のエンコード
set fileencodings=utf-8,euc-jp,sjis  " 読み込む際のエンコード
set fileformats=unix,dos,mac         " 改行コードの自動認識

" ミュート設定
set visualbell t_vb=      " 画面のフラッシュをさせない
set noerrorbells          " エラー時のビープ音をオフ

" 表示
set list                " 不可視文字の可視化
set number              " 行番号の表示
set cursorline          " カーソルのあるラインをハイライト
set wrap                " 長いテキストの折り返し
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=1         " マッチした括弧にカーソルを一瞬だけしか飛ばさない (デフォルト:5)
set display=lastline    " 長い行を省略させない
set t_Co=256            " 256色対応

" 編集
set textwidth=0                  " 自動的に改行が入るのを無効化
set tabstop=4                    " TABはスペース4つと見倣す
set expandtab                    " ソフトタブを有効化 TABの代わりにスペースを入力
set backspace=indent,eol,start   " バックスペースでTAB、改行、文字の削除

" クリップボートの共有
if has('mac')
  set clipboard=unnamed,autoselect
elseif has('unix')
  " for Ubuntu14
  set clipboard=unnamedplus
endif

" <>をペアとする
set matchpairs& matchpairs+=<:>

" tab, 行末のスペース, 改行コード等の表示フォーマット設定
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 検索
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ(リアルタイムで候補選択）
set hlsearch            " 検索マッチテキストをハイライト

" Swap / Backupファイルを作成しない
set nowritebackup
set nobackup
set noswapfile

" ステータスバーにファイル名、文字エンコード、改行コードの表示
set laststatus=2
set statusline=%F%m%r%h%w\%=%{exists('g:loaded_fugitive')?fugitive#statusline():''}[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
highlight statusline term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=black

" Key操作
" insert mode時にjjと入力した場合はESC
inoremap jj <Esc>
" 行全体のヤンクを現在地から行末までヤンクに変更
nnoremap Y y$
" 行頭、行末への移動をマップ
inoremap <C-e> <Esc>$
inoremap <C-a> <Esc>^
noremap <C-e> <Esc>$
noremap <C-a> <Esc>^
" カーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" インクリメント/デクリメント
nnoremap + <C-a>
nnoremap - <C-x>
" Esc2回でハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>

" dein.vim settings
if &compatible
  set nocompatible
endif

" ディレクトリ設定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在しない場合clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('Shougo/dein.vim')

  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " ファイルをツリー表示
  call dein#add('scrooloose/nerdtree')

  " カラースキーム
  call dein#add('tomasr/molokai')

  " 末尾のスペースをハイライトさせる
  call dein#add('bronson/vim-trailing-whitespace')

  " インデントを可視化させる
  call dein#add('Yggdroot/indentLine')

  " Gitコマンド
  call dein#add('tpope/vim-fugitive')

  " 差分を表示
  call dein#add('airblade/vim-gitgutter')

  " 編集中にコードを実行できるようにする
  call dein#add('thinca/vim-quickrun')

  " quickrun hook
  call dein#add('osyo-manga/shabadou.vim')

  " 構文チェック
  call dein#add('osyo-manga/vim-watchdogs')

  " pep8チェック
  call dein#add('nvie/vim-flake8')

  " Pythonの構文をリアルタイムでチェック
  call dein#add('kevinw/pyflakes-vim')

  " C++11/14/17のシンタックスハイライト
  call dein#add('octol/vim-cpp-enhanced-highlight')

  "quickfixを参照しエラー箇所をハイライトする
  call dein#add('jceb/vim-hier')

  "jsonでダブルクォートの可視化
  call dein#add('elzr/vim-json')

  call dein#end()
  call dein#save_state()
endif

" 未インストールのプラグインをインストール
if dein#check_install()
  call dein#install()
endif

" vim-quickrunの設定
" 実行時に縦方向に実行結果を表示 / 結果に実行時間を表示
let g:quickrun_config = {
\  '_': {
\    'outputter/buffer/split': '8',
\    'hook/time/enable': '1'
\  }
\}
" 下画面に実行結果を表示
set splitbelow

" 書き込み後に構文チェック
let g:watchdogs_check_BufWritePost_enable = 1

" c++のみ
let g:watchdogs_check_BufWritePost_enables = {
\   "python" : 0,
\   "cpp" : 1
\}

" 一定時間入力がない場合構文チェック
" バッファに書き込み後、1度だけ行われる
let g:watchdogs_check_CursorHold_enable = 1

" c++のみ有効, watchdogs_check_bufWritePost_enablesとは別なので注意
let g:watchdogs_check_CursorHold_enables = {
\   "python" : 0,
\   "cpp"   : 1
\}

" シンタックスチェックのため
call watchdogs#setup(g:quickrun_config)

if executable('flake8')
  " flake8の結果を表示
  let g:flake8_show_quickfix=1

  " 行番号の左にエラーマーク等を表示
  let g:flake8_show_in_gutter=1

  " vim-flake8の結果出力と競合させないため非表示
  let g:pyflakes_use_quickfix=0
endif

" jsonのダブルクォートを可視化するため
let g:vim_json_syntax_conceal = 0

" dein.vimの後でないと有効にならない
syntax on               " シンタックスハイライト
colorscheme molokai     " カラースキーム設定

" filetype関連をonにする
filetype plugin indent on

" インデントの設定
autocmd BufNewFile,BufRead *.py  setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
