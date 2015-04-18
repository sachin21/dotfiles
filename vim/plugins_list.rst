========================================
入れてるプラグインのリスト
========================================

---------------------------------------------
管理系
---------------------------------------------
vim-pathogen : bundleディレクトリ配下にpluginを配置することでプラグイン管理を簡単に
- http://www.vim.org/scripts/script.php?script_id=2332
- http://www.allenwei.cn/tips-using-git-submodule-keep-your-plugin-up-to-date/
- http://tech.kayac.com/archive/vim-plugin-coding.html

---------------------------------------------
表示系
---------------------------------------------
smooth_scroll.vim : スクロールを賢く
- http://www.vim.org/scripts/script.php?script_id=1601
- http://blog.blueblack.net/item_219

---------------------------------------------
編集系
---------------------------------------------
Align : 高機能整形・桁揃えプラグイン
- http://vim.sourceforge.net/scripts/script.php?script_id=294
- http://nanasi.jp/articles/vim/align/align_vim.html
- http://vimwiki.net/?scripts%2F4

surround.vim : テキストを括弧で囲む／削除する
- http://www.vim.org/scripts/script.php?script_id=1697
- http://vimwiki.net/?scripts%2F16
- http://github.com/tpope/vim-surround

SQLUtilities : SQL整形、生成ユーティリティ
- http://www.vim.org/scripts/script.php?script_id=492
- http://vimwiki.net/?scripts%2F20

NERD_commenter.vim :最強コメント処理 (<Leader>c<space>でコメントをトグル)
- http://www.vim.org/scripts/script.php?script_id=1218
- http://www.sopht.jp/blog/index.php?/archives/446-NERD_commenter.html
- http://github.com/scrooloose/nerdcommenter

YankRing.vim : ヤンクの履歴を管理し、順々に参照、出力できるようにする
- http://www.vim.org/scripts/script.php?script_id=1234
- http://nanasi.jp/articles/vim/yankring_vim.html
- http://d.hatena.ne.jp/seiunsky/20080517/1211051041

quickrun.vim : 編集中のファイルを簡単に実行できるプラグイン
- http://github.com/thinca/vim-quickrun
- http://www.vim.org/scripts/script.php?script_id=2419
- http://vim-users.jp/2009/05/hack7/
- http://d.hatena.ne.jp/pcmaster/20090510/p2
- http://tech.kayac.com/archive/vim-3-plugin.html

autocomplpop.vim : insertmodeで自動で補完をpopup
  http://sites.google.com/site/fudist/Home/vim-nihongo-ban
  http://www.vim.org/scripts/script.php?script_id=1879
  http://vim.g.hatena.ne.jp/keyword/autocomplpop.vim

  neocomplcache.vim : 究極のVim的補完環境
  - http://github.com/Shougo/neocomplcache/blob/998764e1072fa5b183c3da4705b8187658fa0b41/presen/neocomplcache.txt
  - http://vim-users.jp/2009/07/hack-49/
  - http://www.vim.org/scripts/script.php?script_id=2620
  - http://d.hatena.ne.jp/yuitowest/20100907/1283865197

cecutil.vim : 他のpluginのためのutillity1
- http://www.vim.org/scripts/script.php?script_id=1066

smartchr.vim : ==などの前後を整形
- http://www.vim.org/scripts/script.php?script_id=2290
- http://project-p.jp/halt/anubis/blog_show/1068
- http://d.hatena.ne.jp/ampmmn/20080928/1222590293

vim-operator-user : 簡単にoperatorを定義できるようにする
- https://github.com/kana/vim-operator-user
- http://relaxedcolumn.blog8.fc2.com/blog-entry-154.html

operator-camelize : camel-caseへの変換
- https://github.com/tyru/operator-camelize.vim

operator-replace : yankしたものでreplaceする
- https://github.com/kana/vim-operator-replace
- http://www.vim.org/scripts/script.php?script_id=2782
- http://vim.g.hatena.ne.jp/yamazakiccs/20090913

textobj-user : 簡単にVimエディタのテキストオブジェクトをつくれる
- http://www.vim.org/scripts/script.php?script_id=2100
- http://d.hatena.ne.jp/taku-o/20100323/1269369154

vim-textobj-syntax : syntax hilightされたものをtext-objectに
- https://github.com/kana/vim-textobj-syntax

vim-textobj-lastpat : 最後に検索されたパターンをtext-objectに
- https://github.com/kana/vim-textobj-lastpat

vim-textobj-jabraces : 「foo」 or 【bar】などをtext-objectに
- https://github.com/kana/vim-textobj-jabraces

vim-textobj-indent : インデントされたものをtext-objectに
- https://github.com/kana/vim-textobj-indent.git

vim-textobj-function : 関数の中身をtext-objectに
- https://github.com/kana/vim-textobj-function.git

vim-textobj-fold : 折りたたまれたアレをtext-objectに
- https://github.com/kana/vim-textobj-fold.git

vim-textobj-entire : buffer全体をtext-objectに
- https://github.com/kana/vim-textobj-entire.git

vim-textobj-plugins : いろんなものをtext-objectにする
- https://github.com/thinca/vim-textobj-plugins
- http://d.hatena.ne.jp/thinca/20090426/1240675033

vim-smartword : 単語移動がスマートな感じで
- http://www.vim.org/scripts/script.php?script_id=2470
- https://github.com/kana/vim-smartword/

camelcasemotion : CamelCaseやsnake_case単位でのワード移動
- http://www.vim.org/scripts/script.php?script_id=1905
- http://nanasi.jp/articles/vim/camelcasemotion_vim.html

---------------------------------------------
検索系
---------------------------------------------
eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
- http://d.hatena.ne.jp/secondlife/20060203/1138978661
- http://www.vector.co.jp/soft/dl/unix/writing/se265654.html

grep.vim : 外部のgrep利用。:Grepで対話形式でgrep :Rgrepは再帰
- http://d.hatena.ne.jp/secondlife/20060203/1138978661
- http://www.vim.org/scripts/script.php?script_id=311

---------------------------------------------
バッファ管理系
---------------------------------------------
bufexplorer.vim : <Leader>beでバッファのリストを表示
- http://www.vim.org/scripts/script.php?script_id=42

minibufexpl.vim : タブエディタ風にバッファ管理ウィンドウを表示
- http://www.vim.org/script.php?script_id=159
- http://nanasi.jp/articles/vim/minibufexpl_vim.html

  fuzzyfinder.vim : 超あいまいバッファ検索
    http://www.vim.org/scripts/script.php?script_id=1984
    http://d.hatena.ne.jp/ns9tks/20080104/1199432216

DumbBuf.vim : quickbufっぽくbufferを管理。とりあえず<F4>でバッファ一覧
- http://vim.g.hatena.ne.jp/tyru/20091030
- http://github.com/tyru/DumbBuf.vim/downloads

unite.vim : - すべてを破壊し、すべてを繋げ - vim scriptで実装されたanythingプラグイン
- http://github.com/Shougo/unite.vim
- http://tech.kayac.com/archive/vim-plugin-coding.html
- http://sites.google.com/site/kjwiki1/home/vim/unite-vim
- http://www.st-prestage.jp/blog/mac/771
- http://www.slideshare.net/Shougo/unite-vim
- http://d.hatena.ne.jp/basyura/20100908/p1
- http://d.hatena.ne.jp/thinca/searchdiary?word=%2A%5Bunite%5D

---------------------------------------------
ファイル系
---------------------------------------------
NERDTree : ツリー型エクスプローラ
- http://www.vim.org/scripts/script.php?script_id=1658
- http://vimwiki.net/?scripts%2F18
- http://wagnad.blog9.fc2.com/blog-entry-504.html
- http://github.com/scrooloose/nerdtree

project.vim : IDE風のファイル管理
- http://d.hatena.ne.jp/hidde/20080930/1222776171
- http://hoshinanonikki.net/20070820.html
- http://www.vim.org/scripts/script.php?script_id=69

vtreeexplorer.vim : ツリー状にファイルやディレクトリの一覧を表示
- http://www.vim.org/scripts/script.php?script_id=184
- http://d.hatena.ne.jp/obys/20061119/1163939621

---------------------------------------------
その他
---------------------------------------------
git-vim : gitをvimでー
- http://github.com/motemen/git-vim/tree/master
- http://vim-users.jp/2009/09/hack67/

urilib.vim : vim scriptからURLを扱うライブラリ
- https://github.com/tyru/urilib.vim

open-browser.vim : URLをブラウザで開く
- https://github.com/tyru/open-browser.vim
- http://d.hatena.ne.jp/tyru/20100619/git_push_vim_plugins_to_github

hatena.vim : vimからはてなダイアリーを更新
- http://d.hatena.ne.jp/snaka72/20090124/1232801656
- https://github.com/motemen/hatena-vim

vimproc : vimから非同期実行。vimshelleで必要
- https://github.com/Shougo/vimproc

vimshell : vimのshell
- https://github.com/Shougo/vimshell
- http://d.hatena.ne.jp/pcmaster/20090505/p1
- http://vim-users.jp/tag/vimshell/

vim-altercmd : Ex command拡張
- https://github.com/tyru/vim-altercmd

---------------------------------------------
開発系
---------------------------------------------
vim-ruby : VimでRubyを扱う際の最も基本的な拡張機能
- http://sssdiary.at.webry.info/200611/article_7.html
- http://blog.blueblack.net/item_133
- http://github.com/vim-ruby/vim-ruby

refe.vim : vimからrefeでRuby のリファレンスマニュアルのエントリを引く
- http://rails2u.com/projects/refe.vim/
- http://blog.blueblack.net/item_187
- http://relaxedcolumn.blog8.fc2.com/blog-entry-108.html
- http://i.loveruby.net/ja/prog/refe.html

rails.vim : rails的なアレ
- http://www.vim.org/scripts/script.php?script_id=1567
- http://d.hatena.ne.jp/secondlife/20061222/1166781841
- http://github.com/tpope/vim-rails

vim-ref : perldocやphpmanual等のリファレンスをvim上で見るためのプラグイン
- http://tech.kayac.com/archive/vim-plugin-coding.html
- http://github.com/thinca/vim-ref

python.vim : 自前で用意したpython用の設定.indentのみ設定

Pydiction : Python用の入力補完
- http://www.vim.org/scripts/script.php?script_id=850
- http://d.hatena.ne.jp/shuji_w6e/20090908/1252418641

scala.vim : 自前で用意したscala用の設定

