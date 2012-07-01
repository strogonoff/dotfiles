call pathogen#runtime_append_all_bundles()

" This is a mess

set nocompatible

" Enable copying in OS X
set clipboard=unnamed

" Mouse stuff
set ttymouse=xterm2
set mouse=a

filetype plugin on
filetype plugin indent on
syntax on
set noswapfile

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter

" Display how far away each line is from the current one
"set relativenumber
"set numberwidth=5

"SWAGG
set relativenumber                           " setting line numbers
set colorcolumn=81                           " line to show 81 character mark
set cursorline                               " shows the horizontal cursor line

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>    " mapping to edit my vimrc quickly
:nnoremap <leader>sv :source $MYVIMRC<cr>    " mapping to source my vimrc quickly

set wildmenu

" Keep buffer when a tab is closed
set hidden

" Don't jump to matching bracket
set noshowmatch

" Command line
set showcmd
set cmdheight=2

" Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Convert tabs to spaces
set expandtab
set autoindent

" Python highlights
let python_highlight_numbers = 1
let python_highlight_space_errors = 1
let python_highlight_builtins = 0

let g:pymode_folding = 1            " python-mode

" Modeline (comments with VIM settings in files)
setglobal modeline
setglobal modelines=5

" Filetype-specific settings
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType styl setlocal shiftwidth=2 tabstop=2
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType rst setlocal shiftwidth=2 tabstop=2
autocmd FileType mustache setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4

autocmd BufEnter *.htm* setlocal filetype=htmldjango
autocmd BufEnter *.less setlocal filetype=less

" Make semicolon act like colon
nnoremap ; :
nnoremap : ;

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" When we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
    \ if expand("<afile>:p:h") !=? $TEMP |
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ let JumpCursorOnEdit_foo = line("'\"") |
    \ let b:doopenfold = 1 |
    \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \ let b:doopenfold = 2 |
    \ endif |
    \ exe JumpCursorOnEdit_foo |
    \ endif |
    \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \ exe "normal zv" |
    \ if(b:doopenfold > 1) |
    \ exe "+".1 |
    \ endif |
    \ unlet b:doopenfold |
    \ endif
augroup END

" Splitting
map <C-K> <C-W>k<C-W>_ 
map <C-J> <C-W>j<C-W>_
set wmh=0

" Folding Indent
    set foldmethod=indent
    set foldnestmax=10
    set foldminlines=3
    syn sync fromstart
    hi Folded term=none cterm=none
    " Text on closed fold
    function MyFoldText()
        let line = getline(v:foldstart)
        return line
        let line = substitute(line, '-', '', 'g')
        let line = substitute(line, '^\s*', '', 'g')
        let lcount = v:foldend - v:foldstart
        let spaces = ''
        let spacess = ''
        let i = 0
        let h = 0
        while h < &tabstop
            let spacess = ' ' . spacess
            let h = h + 1
        endwhile
        while i < v:foldlevel
            let spaces = spacess . spaces
            let i = i + 1
        endwhile
        return spaces . line . '----' . '(+ ' . lcount . ')'
    endfunction
    set foldtext=MyFoldText()

" Switch mode: handle either buffer or window c-j/c-k switches
function MapForBuffers()
    noremap <c-j> :only<cr>:bnext<cr>
    inoremap <c-j> <esc>:only<cr>:bnext<cr>
    noremap <c-k> :only<cr>:bprev<cr>
    inoremap <c-k> <esc>:only<cr>:bprev<cr>
    :only
endfunction

function MapForWindows()
    :unhide
    noremap <c-j> <c-w>j<c-w>_
    inoremap <c-j> <esc><c-w>j<c-w>_
    noremap <c-k> <c-w>k<c-w>_
    inoremap <c-k> <esc><c-w>k<c-w>_
endfunction

function MapSwitchMode()
    if g:switchmode == "windows"
        call MapForWindows()
    else
        call MapForBuffers()
    endif
endfunction

let g:switchmode = "windows"
call MapSwitchMode()

function ToggleSwitchMode()
    if g:switchmode == "windows"
        let g:switchmode = "buffers"
    else
        let g:switchmode = "windows"
    endif
    call MapSwitchMode()

endfunction

noremap <F4> :call ToggleSwitchMode()<cr>:echo "Switching mode now: " . g:switchmode<cr>
" End switch mode code

" Paste toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc

nnoremap <silent> <F7> :call Paste_on_off()<CR>
set pastetoggle=<F7>

" Folding toggle
nnoremap <space> za

" Appearance
set background=light
if has("gui_running")
    let g:solarized_bold=1
    let g:solarized_underline=1
    color solarized
    set columns=85
    set lines=30
    set guifont=Consolas:h14
    set fuoptions=background:#ff1a1a1a
    set transp=5
    " Shortcuts for going fullscreen (:fu) and back (:nofu)
    " with transparency change
    ca fu set fu transp=0
    ca nofu set nofu transp=5
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set guioptions-=L " Force remove left sidebar even if vertical split
else
    "let g:solarized_termtrans=1
    color Tomorrow-Night-Eighties
endif

" ??
nmap <ESC><C-P> k

"Command-T
    " Here are my mappings for starting a file search with Command-T.
    " I start a project-wide search with ,f and search the directory of the current file with ,F:
    " use comma as <Leader> key instead of backslash
    let mapleader=","

    " double percentage sign in command mode is expanded
    " to directory of current file - http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>

    noremap <Leader>b :CommandTFlush<cr>\|:CommandTBuffer<cr>
    noremap <leader>f :CommandTFlush<cr>\|:CommandT<cr>
    noremap <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

    let g:CommandTAcceptSelectionSplitMap=['<C-g>']
    "let g:CommandTAcceptSelectionMap=['<C-CR>']

"recalculate the trailing whitespace warning when idle, and after saving
"syntax error highlighting
    autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
    let g:syntastic_check_on_open=1
    let g:syntastic_enable_signs=0

    "return '[\s]' if trailing white space is detected
    "return '' otherwise
    function! StatuslineTrailingSpaceWarning()
        if !exists("b:statusline_trailing_space_warning")

            if !&modifiable
                let b:statusline_trailing_space_warning = ''
                return b:statusline_trailing_space_warning
            endif

            if search('\s\+$', 'nw') != 0
                let b:statusline_trailing_space_warning = '[\s]'
            else
                let b:statusline_trailing_space_warning = ''
            endif
        endif
        return b:statusline_trailing_space_warning
    endfunction


    "return the syntax highlight group under the cursor ''
    "Not used actually, distracting
    function! StatuslineCurrentHighlight()
        let name = synIDattr(synID(line('.'),col('.'),1),'name')
        if name == ''
            return ''
        else
            return '[' . name . ']'
        endif
    endfunction

    "recalculate the tab warning flag when idle and after writing
    autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

    "return '[&et]' if &et is set wrong
    "return '[mixed-indenting]' if spaces and tabs are used to indent
    "return an empty string if everything is fine
    function! StatuslineTabWarning()
        if !exists("b:statusline_tab_warning")
            let b:statusline_tab_warning = ''

            if !&modifiable
                return b:statusline_tab_warning
            endif

            let tabs = search('^\t', 'nw') != 0

            "find spaces that arent used as alignment in the first indent column
            let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

            if tabs && spaces
                let b:statusline_tab_warning = '[mixed-indenting]'
            elseif (spaces && !&et) || (tabs && &et)
                let b:statusline_tab_warning = '[&et]'
            endif
        endif
        return b:statusline_tab_warning
    endfunction

    "recalculate the long line warning when idle and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

    "return a warning for "long lines" where "long" is either &textwidth or 80 (if
    "no &textwidth is set)
    "
    "return '' if no long lines
    "return '[#x,my,$z] if long lines are found, were x is the number of long
    "lines, y is the median length of the long lines and z is the length of the
    "longest line
    function! StatuslineLongLineWarning()
        if !exists("b:statusline_long_line_warning")

            if !&modifiable
                let b:statusline_long_line_warning = ''
                return b:statusline_long_line_warning
            endif

            let long_line_lens = s:LongLines()

            if len(long_line_lens) > 0
                let b:statusline_long_line_warning = "[" .
                            \ '#' . len(long_line_lens) . "," .
                            \ 'm' . s:Median(long_line_lens) . "," .
                            \ '$' . max(long_line_lens) . "]"
            else
                let b:statusline_long_line_warning = ""
            endif
        endif
        return b:statusline_long_line_warning
    endfunction

    "return a list containing the lengths of the long lines in this buffer
    function! s:LongLines()
        let threshold = (&tw ? &tw : 80)
        let spaces = repeat(" ", &ts)

        let long_line_lens = []

        let i = 1
        while i <= line("$")
            let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
            if len > threshold
                call add(long_line_lens, len)
            endif
            let i += 1
        endwhile

        return long_line_lens
    endfunction

    "find the median of the given array of numbers
    function! s:Median(nums)
        let nums = sort(a:nums)
        let l = len(nums)

        if l % 2 == 1
            let i = (l-1) / 2
            return nums[i]
        else
            return (nums[l/2] + nums[(l/2)-1]) / 2
        endif
    endfunction

    "statusline setup
    set statusline=%f "tail of the filename

    "display a warning if fileformat isnt unix
    set statusline+=%#warningmsg#
    set statusline+=%{&ff!='unix'?'['.&ff.']':''}
    set statusline+=%*

    "display a warning if file encoding isnt utf-8
    set statusline+=%#warningmsg#
    set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
    set statusline+=%*

    set statusline+=%h "help file flag
    set statusline+=%y "filetype
    set statusline+=%r "read only flag
    set statusline+=%m "modified flag

    "display a warning if &et is wrong, or we have mixed-indenting
    set statusline+=%#error#
    set statusline+=%{StatuslineTabWarning()}
    set statusline+=%*

    set statusline+=%{StatuslineTrailingSpaceWarning()}

    set statusline+=%{StatuslineLongLineWarning()}

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    "display a warning if &paste is set
    set statusline+=%#error#
    set statusline+=%{&paste?'[paste]':''}
    set statusline+=%*

    set statusline+=%= "left/right separator

    function! SlSpace()
        if exists("*GetSpaceMovement")
            return "[" . GetSpaceMovement() . "]"
        else
            return ""
        endif
    endfunc
    set statusline+=%{SlSpace()}

    set statusline+=%c, "cursor column
    set statusline+=%l/%L "cursor line/total lines
    set statusline+=\ %P "percent through file
    set laststatus=2

" Powerline
let g:Powerline_symbols = 'fancy'

" Gundo
nnoremap <F5> :GundoToggle<CR>
