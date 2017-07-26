scriptencoding utf-8

" エンコード
set fileencoding=utf-8               " 書き込む際のエンコード
set fileencodings=utf-8,euc-jp,sjis  " 読み込む際のエンコード
set fileformats=unix,dos,mac         " 改行コードの自動認識

" ミュート設定
set visualbell t_vb=      " 画面のフラッシュをさせない
set noerrorbells          " エラー時のビープ音をオフ


" 表示
syntax on               " シンタックスハイライト
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=1         " マッチした括弧にカーソルを一瞬だけしか飛ばさない (デフォルト:5)
set display=lastline    " 長い行を省略させない

" 編集
set textwidth=0                  " 自動的に改行が入るのを無効化
set tabstop=4                    " TABはスペース4つと見倣す
set expandtab                    " ソフトタブを有効化 TABの代わりにスペースを入力
set backspace=indent,eol,start   " バックスペースでTAB、改行、文字の削除
set clipboard=unnamed,autoselect " クリップボートの共有

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
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
highlight statusline term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=black

" Key操作
inoremap jj <Esc>  " insert mode時にjjと入力した場合はESC
nnoremap Y y$      " 行全体のヤンクを現在地から行末までヤンクに変更

" Mouse操作の有効化
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
