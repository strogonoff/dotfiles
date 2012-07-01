" Vim filetype plugin
" Language:	SCSS
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2010 Jul 26

if exists("b:did_ftplugin")
  finish
endif

setlocal suffixesadd=.scss,.css

runtime! ftplugin/sass.vim

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" vim:set sw=2:
