" Vim color file
" Maintainer:	David Schweikert <dws@ee.ethz.ch>
" Last Change:	2001 Mai 14

let colors_name = "tommy"

"hi Comment term=NONE cterm=NONE guifg=Grey ctermfg=Grey
"hi Comment term=NONE cterm=NONE guifg=LightBlue ctermfg=LightBlue
hi Comment term=NONE cterm=NONE guifg=LightCyan ctermfg=LightCyan
" hi Comment    term=NONE      cterm=NONE ctermfg=darkred      gui=NONE guifg=red2

if exists("syntax_on")
  let syntax_cmd = "enable"
  runtime syntax/syncolor.vim
  unlet syntax_cmd
endif

" vim: sw=2
