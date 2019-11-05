" $Id: .vimrc,v 1.10 2009-02-19 10:38:57 x-way Exp $

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Personal Configuration
set number		" show line numbers
set showmode		" show mode in status line
set noexpandtab
set shiftwidth=8
set tabstop=8
set nobackup 
set nowritebackup
set showmatch		" briefly jump to matching parenthesis when entering the second one

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set wrapscan		" start again at the beginning when reaching eof

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Syntax highlighting {{{
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" }}}

set loadplugins

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  " highlight 'TBD' in latex/tex files
  autocmd FileType tex match Todo /TBD/
else

set autoindent		" always set autoindenting on

endif " has("autocmd")

"let g:netrw_ftp_cmd = "ftp -z nossl"

" 256-colors :-)
"set t_Co=256

" Python {{{
if has('python')
" gf on an import statement shows the corresponding file
python << EOF
import os
import sys
import vim
for p in sys.path:
	if os.path.isdir(p):
		vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endif
" }}}
" enable modelines {{{
set modeline
set modelines=5
" }}}

set title		" show vim-title in xterm

if (&term =~ '^screen')
	" set title for screen
	set title
	set t_ts=k
	set t_fs=\
	set titlelen=15
endif

" Backups (not enabled) {{{
if has("unix")
	if !isdirectory(expand("~/tmp/."))
		!mkdir -p ~/tmp/
	endif
endif
set bdir=~/tmp
" }}}

"set mouse=a "enable mouse scrolling!!!

" use Windows clipboard (if available) {{{
if has("win32")
	set clipboard+=unnamed
endif
"}}}
" Print sntax highlighting {{{
set printoptions+=syntax:y
" }}}
" Perl coding guidelines {{{
autocmd FileType perl set expandtab shiftwidth=4 softtabstop=4
" }}}
" paint background grey for everything longer than 80 characters {{{
"highlight OverLength ctermbg=DarkGrey guibg=DarkGrey
"match OverLength /\%>80v.\+/
" }}}
" Ruler {{{
" don't want to waste space by having an extra statusline, thus we gave to
" hack all this stuff into the ruler
" see https://gabri.me/blog/diy-vim-statusline for inspiration regarding the
" mode display
set rulerformat=%{toupper(mode())}\ \ \ %l,%c%V%=%P
" }}}
" .vimrc modeline {{{
" enable folding for this .-vimrc file (to organize it's contents)
" from: https://dougblack.io/words/a-good-vimrc.html#organization
" vim:foldmethod=marker:foldlevel=0
" }}}
