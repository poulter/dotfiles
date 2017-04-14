
"mappings
map               <F1> :set number! number?<CR>
map               <F2> :set paste! paste?<CR>
set                     pastetoggle=<F2>
map               <F3> :set list! nolist?<CR>
map               <F4> :call NumberToggle()<CR>
"map              <F5> /SIMERROR\\|^FATAL\\|^ERROR\\|Error:\\|^WARN\\|Warning-\\|started at .* failed at <CR>
map               <F5> /\*E\\|UVM_FATAL\\|UVM_ERROR\\|: ERROR \\|ERROR *:\\|^error *:\\|^Error *:\\|--- Stack trace follows:\\|Error-\\|vcs_sim_exe:.*Assertion.*failed\\|^ *\d*:* *FAIL<CR>
nnoremap <silent> <F7> :Tlist<CR>
map  <silent>     <F8> :Tmux <Up><CR>
map  <silent>     <F9> :call Dropmarker()<CR>
map  <silent>   <S-F9> :call Fixdroppedmarkers()<CR>
map  <silent>   <A-F9> :call Removedroppedmarkers()<CR>
map  <silent>   <C-F9> :call Removedroppedmarkers()<CR>
map  <silent> <S-A-F9> :call Removedroppedmarkers()<CR>
map  <silent> <S-C-F9> :call Removedroppedmarkers()<CR>
map              <F11> :!perl -c % \|& tee ~/.vim/perlout<CR>:bel split ~/.vim/perlout<CR>:1<CR>^W p<CR>
map      <silent> t     :TagbarToggle<CR>
map      <silent> <Leader>cd <Plug>RooterChangeToRootDirectory<CR>:pwd<CR>

map gD :!chrome "http://www.m-w.com/cgi-bin/dictionary?book=Dictionary&va=<cword>" >& /dev/null &<CR><CR>
map gG :!chrome "http://www.google.com/search?q=<cword>"                           >& /dev/null &<CR><CR>
map gS :!chrome "http://siyobik.info.gf/main/reference/instruction/<cword>"        >& /dev/null &<CR><CR>

" runtime! autoload/pathogen.vim
" if exists('g:loaded_pathogen')
"   call pathogen#surround('~/.vim/bundles/{}')
"   call pathogen#infect()
"   call pathogen#helptags()
" end

call plug#begin('~/.vim/plugged')

" Generic Programming
Plug 'tpope/vim-sleuth'                          " heuristic tab stops
Plug 'jgdavey/tslime.vim'                        " run builds from vim to tmux
Plug 'vim-scripts/Align'                         " character alignment
Plug 'ervandew/supertab'                         " tab for all completions
Plug 'kien/rainbow_parentheses.vim'              " visually match parens
Plug 'scrooloose/syntastic'                      " Syntax checking on save
Plug 'triglav/vim-visual-increment'              " columnar number increment

" snippets
Plug 'MarcWeber/vim-addon-mw-utils'              " required by snipmate
Plug 'garbas/vim-snipmate'                       " snippet support

" Data Files
Plug 'jrosiek/vim-mark'                          " mark searches
Plug 'vim-scripts/LargeFile'                     " turn stuff off when the file is really big

" Version Control
Plug 'vim-scripts/vcscommand.vim'                " version control in general
Plug 'jdthomas/vcsp4'                            " perforce

" Planning and Documentation
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

" SystemVerilog
Plug 'Spaceghost/vim-matchit'                    " begin...end matching for systemverilog
Plug 'poulter/vim-SystemVerilog'                 " syntax, snippets, and matchit

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

" Markdown
Plug 'plasticboy/vim-markdown'

if filereadable(glob("~/local_plugins.vim"))
  so ~/local_plugins.vim
endif

" url = https://github.com/tomtom/tlib_vim.git
" url = https://github.com/Lokaltog/vim-easymotion.git
" url = https://github.com/vim-scripts/YankRing.vim.git
" url = https://github.com/tpope/vim-pathogen.git
" url = https://github.com/vim-scripts/closetag.vim.git
" url = https://github.com/vim-scripts/taglist.vim.git
" url = https://github.com/vim-scripts/DrawIt.git
" url = https://github.com/kien/ctrlp.vim.git
" url = https://github.com/airblade/vim-rooter.git
" url = https://github.com/vim-scripts/AutoTag.git
" url = https://github.com/majutsushi/tagbar.git
" url = https://github.com/scrooloose/nerdtree.git
" url = https://github.com/tpope/vim-abolish.git
" url = https://github.com/tpope/vim-endwise.git
" url = https://github.com/tpope/vim-repeat.git
" url = https://github.com/scrooloose/nerdcommenter.git
" url = https://github.com/tpope/vim-surround.git
" url = https://github.com/mhagger/git-when-merged
call plug#end()

" set relativenumber
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


" folding 
set foldmethod=syntax
let g:vimwiki_folding='syntax'
set foldnestmax=10
set foldenable

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
set softtabstop=3
set shiftwidth=3
set expandtab

" rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au BufRead,BufNewFile *.log RainbowParenthesesToggle

function! Ieslog()
  " change , to : for errors
  g/,\(\d\+\)|/s//:\1|
  g/,\(\d\+\)): /s//:\1):
  g/file: \S\+\zs, line = \(\d\+\)\ze/s//:\1
  " return to previous line
  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endfunction

:let g:syntastic_ruby_checkers = ["mri","rubocop"]

augroup filetype
  au! BufRead,BufNewFile cmd.log                           silent! call Ieslog()
  au! BufRead,BufNewFile *.vri,*.vrh,*.vr                       set filetype=vera
  au! BufRead,BufNewFile sim.cfg                                set filetype=perl
  "au! BufRead,BufNewFile *.v,*.sv,*.vbh,*.stm,*.vbh.aml,*.v_tpl set filetype=systemverilog
  "au! BufRead,BufNewFile *.v,*.sv,*.vbh,*.stm,*.vbh.aml,*.v_tpl set filetype=verilog_systemverilog
  au! BufRead,BufNewFile *.god,*.pill,Gemfile,*.simeta          set filetype=ruby
  au! BufRead,BufNewFile                      *.simeta.erb      let b:eruby_subtype='ruby'|set filetype=eruby
  au! BufRead,BufNewFile *.yaml, *.yml                          let b:eruby_subtype='yaml'|set filetype=eruby
  au! BufRead,BufNewFile *.sv.erb                               let b:eruby_subtype='systemverilog'  |set filetype=eruby
  "au BufRead,BufNewFile *.sv                                    set filetype=systemverilog.doxygen
  au BufNewFile,BufRead *.doxygen                               setfiletype doxygen
  au BufNewFile,BufReadPost *.md                                set filetype=markdown
augroup END

:au FileType systemverilog,verilog_systemverilog let b:delimitMate_quotes = "\""

" note taking with markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'systemverilog']
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_level = 10
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_override_foldtext = 0

" vimwiki
command! -nargs=1 Ngrep vimgrep "<args>" ~/vimwiki/*.wiki
nnoremap <leader>[ :Ngrep 
autocmd BufRead,BufNewFile diary.wiki if @% =~ "tpoulter" | execute "VimwikiDiaryGenerateLinks" | endif

" calendar
let g:calendar_keys = { 'goto_next_month' : 'n', 'goto_prev_month' : 'p', 'goto_next_year'  : 'N',  'goto_prev_year'  : 'P' }

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
set tags=./tags;/,~/docs/tags,$WORK/tags
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

" turn off syntax and everything else if file is larger than 2G
let g:LargeFile=2000

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
set suffixes=.bak,~,.swp,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.toc

function! Dropmarker()
  call append('.',"$display(\"%0d: DEBUG MARKER " . expand('%:t') . ':' . (line('.')+1) . '", $time);')
  exe line('.') + 2
endfunction
function! Fixdroppedmarkers()
  %s/DEBUG MARKER [^:]\+:\zs\(\d\+\)\ze/\=line('.')
endfunction
function! Removedroppedmarkers()
  %!grep -v '0d: DEBUG MARKER'
endfunction
let g:load_doxygen_syntax=1

if filereadable(glob("~/.vimrc.local"))
  so ~/.vimrc.local
endif
