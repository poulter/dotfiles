
"mappings
map               <F1> :set number! number?<CR>
map               <F2> :set paste! paste?<CR>
set                     pastetoggle=<F2>
map               <F3> :set list! nolist?<CR>
map               <F4> :call NumberToggle()<CR>
"map              <F5> /SIMERROR\\|^FATAL\\|^ERROR\\|Error:\\|^WARN\\|Warning-\\|started at .* failed at <CR>
map               <F5> /\*E\\|\<UVM_FATAL *:\\|\<UVM_ERROR *:\\|^ERROR *:\\|^error *:\\|^Error *:\\|--- Stack trace follows:\\|Error-\\|vcs_sim_exe:.*Assertion.*failed<CR>
nnoremap <silent> <F7> :Tlist<CR>

map               <F10> :!dssc co -get %<CR>
map               <F11> :!perl -c % \|& tee ~/.vim/perlout<CR>:bel split ~/.vim/perlout<CR>:1<CR>^W p<CR>
map      <silent> t     :TagbarToggle<CR>
map      <silent> <Leader>cd <Plug>RooterChangeToRootDirectory<CR>:pwd<CR>

map gD :!chrome "http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va=<cword>" >& /dev/null &<CR><CR>
map gG :!chrome "http://www.google.com/search?q=<cword>"                           >& /dev/null &<CR><CR>
map gS :!chrome "http://siyobik.info.gf/main/reference/instruction/<cword>"        >& /dev/null &<CR><CR>

runtime! autoload/pathogen.vim
if exists('g:loaded_pathogen')
  call pathogen#surround('~/.vim/bundles/{}')
  call pathogen#infect()
  call pathogen#helptags()
end

set relativenumber
function! NumberToggle()
  if (&relativenumber == 1)
    set norelativenumber
    set number
  elseif (&number == 1)
    set nonumber
    set norelativenumber
  else
    set nonumber
    set relativenumber
  endif
endfunction

" tell ctrl-p to open in Normal mode
let g:ctrlp_map = '<c-p>'
let g:ctrlp_show_hidden=1

" separate vim buffer from OS buffer
set clipboard=autoselectml

" more 'normal' key behavior
map!  <backspace>
set backspace=2      " allow backspacing over everything in insert mode
 
" look and feel

set background=dark
" let g:solarized_termcolors=256 " use degraded 256 bit colors
" let g:solarized_termtrans = 1
" colorscheme solarized
" togglebg#map("<F5>") 
colorscheme tommy  " use color scheme for dark backgrounds
" colorscheme vividchalk

set nocompatible     " Use Vim defaults (much better!)

set viminfo='20,\"3000 " read/write a .viminfo file, don't store more than

                     " 50 lines of registers

set history=50       " keep 50 lines of command line history

set ruler            " show the cursor position all the time

set vb

set foldmethod=syntax

set readonly

" set term=xterm-16color
set title

" automatically jump to your last position in the file when you open it in vim:
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" searching
set autoindent
set nohlsearch
set incsearch
set nows
set ignorecase
set smartcase
set nowrapscan

" tabs
set softtabstop=2
set shiftwidth=2
set expandtab

function! Ieslog()
  " change , to : for errors
  g/,\(\d\+\)|/s//:\1|
  g/,\(\d\+\)): /s//:\1):
  g/file: \S\+\zs, line = \(\d\+\)\ze/s//:\1
  " return to previous line
  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endfunction

augroup filetype
  au! BufRead,BufNewFile cmd.log                           silent! call Ieslog()
  au! BufRead,BufNewFile *.vri,*.vrh,*.vr                       set filetype=vera
  "au! BufRead,BufNewFile *.v,*.sv,*.vbh,*.stm,*.vbh.aml,*.v_tpl set filetype=systemverilog
  "au! BufRead,BufNewFile *.v,*.sv,*.vbh,*.stm,*.vbh.aml,*.v_tpl set filetype=verilog_systemverilog
  au! BufRead,BufNewFile *.god,*.pill,Gemfile,*.simeta          set filetype=ruby
  au! BufRead,BufNewFile                      *.simeta.erb      let b:eruby_subtype='ruby'|set filetype=eruby
  au! BufRead,BufNewFile *.yaml                                 let b:eruby_subtype='yaml'|set filetype=eruby
augroup END

" skeletons
autocmd BufNewFile  Makefile*   0r ~/.vim/skeleton/skeleton.mk
autocmd BufNewFile  makefile*   0r ~/.vim/skeleton/skeleton.mk
autocmd BufNewFile  *.vr        0r ~/.vim/skeleton/skeleton.vr
autocmd BufNewFile  *.vri       0r ~/.vim/skeleton/skeleton.vri
autocmd BufNewFile  *.vbh       0r ~/.vim/skeleton/skeleton.vbh
autocmd BufNewFile  *.v         0r ~/.vim/skeleton/skeleton.v
autocmd BufNewFile  *.pl        0r ~/.vim/skeleton/skeleton.pl
autocmd BufNewFile  *.mk        0r ~/.vim/skeleton/skeleton.mk
autocmd BufNewFile  *.h         0r ~/.vim/skeleton/skeleton.h
autocmd BufNewFile  *.C         0r ~/.vim/skeleton/skeleton.C
autocmd BufNewFile  *.rb        0r ~/.vim/skeleton/skeleton.rb

" tags
set tags=./tags;/,~/docs/tags
"let Tlist_Ctags_Cmd = '~/bin/ctags'
"let Tlist_Sort_Type = "name"
"let Tlist_Exit_OnlyWindow = 1

" syntax
syntax on
filetype on
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

"  'autoindent'    uses the indent from the previous line.
"  'smartindent'   is like 'autoindent' but also recognizes some C syntax to
"  'cindent'       Works more cleverly than the other two and is configurable to
"                  different indenting styles.
"  'indentexpr'    The most flexible of all: Evaluates an expression to compute
"                  the indent of a line.  When non-empty this method overrides
"                  the other ones.  See |indent-expression|.
set cindent

au BufReadPost,BufNewFile * if exists("b:current_syntax")
au BufReadPost,BufNewFile *   if b:current_syntax == "perl"
au BufReadPost,BufNewFile *     set nocindent
au BufReadPost,BufNewFile *     set autoindent
au BufReadPost,BufNewFile *   endif
au BufReadPost,BufNewFile * endif

au BufReadPost,BufNewFile *.list      :set nowrap
au BufReadPost,BufNewFile *.log       :set nowrap
au BufReadPost,BufNewFile *.report*   :set nowrap
au BufReadPost,BufNewFile yo*         :set nowrap
au BufReadPost,BufNewFile yo*         :set foldmethod=marker

" grab syntax keywords for completion
if has("autocmd") && exists("+omnifunc") 
  autocmd Filetype * 
\   if &omnifunc == "" | 
\    setlocal omnifunc=syntaxcomplete#Complete | 
\   endif 
endif 

" user stuff
set dir=~/.vim/swp
set ul=1000

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

