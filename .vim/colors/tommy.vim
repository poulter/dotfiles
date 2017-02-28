" Vim color file
" Maintainer:	Tommy Poulter
" Last Change:	2017 Feb 27

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "tommy"

highlight Normal   guifg=White                       guibg=Black
highlight Comment  guifg=LightCyan ctermfg=LightCyan                            


