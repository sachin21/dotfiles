" .vim/syntax/rspec-result.vim
" quickrun.vimでRSpecの実行結果のカラー設定をする | teranishihiroki.com :
" http://teranishihiroki.com/quickrun-vim%E3%81%A7rspec%E3%81%AE%E5%AE%9F%E8%A1%8C%E7%B5%90%E6%9E%9C%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%BC%E8%A8%AD%E5%AE%9A%E3%82%92%E3%81%99%E3%82%8B/
"

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'rspec-result'
endif

"大文字と小文字を区別する
syntax case match

syntax match RSpecGreen /^[\.F]*\.[\.F]*$/
syntax match RSpecGreen /^.*, 0 failures$/
syntax match RSpecRed /F/
syntax match RSpecRed /^.*, [1-9]* failures.*$/
syntax match RSpecRed /^.*, 1 failure.*$/
syntax match RSpecRed /^ *(.*$/
syntax match RSpecRed /^ *expected.*$/
syntax match RSpecRed /^ *got.*$/
syntax match RSpecRed /^ *Failure\/Error:.*$/
syntax match RSpecRed /^.*(FAILED - [0-9]*)$/
syntax match RSpecRed /^rspec .*:.*$/
syntax match RSpecComment / # .*$/
syntax match RSpecNormal /^Failures:/
syntax match RSpecNormal /^Finished/
syntax match RSpecNormal /^Failed/

" 背景色ver.
" highlight RSpecGreen   ctermfg=White ctermbg=Green guifg=White guibg=Green
" highlight RSpecRed     ctermfg=White ctermbg=Red   guifg=White guibg=Red
" highlight RSpecComment ctermfg=White ctermbg=Cyan  guifg=White guibg=Cyan
" highlight RSpecNormal  ctermfg=Black ctermbg=White guifg=Black guibg=White

" 文字色ver.(※ただしMacVimKaoriYaだとうまく動かなかった)
" highlight RSpecGreen   ctermfg=Green ctermbg=none guifg=Green guibg=none
" highlight RSpecRed     ctermfg=Red   ctermbg=none guifg=Red   guibg=none
" highlight RSpecComment ctermfg=Cyan  ctermbg=none guifg=Cyan  guibg=none
" highlight RSpecNormal  ctermfg=White ctermbg=none guifg=Black guibg=White

" 文字色ver.(noneのとこ消したらうまくいった)
highlight RSpecGreen   ctermfg=Green guifg=Green
highlight RSpecRed     ctermfg=Red   guifg=Red
highlight RSpecComment ctermfg=Cyan  guifg=Cyan
highlight RSpecNormal  ctermfg=White guifg=Black guibg=White

let b:current_syntax = 'rspec-result'

if main_syntax == 'rspec-result'
  unlet main_syntax
endif
