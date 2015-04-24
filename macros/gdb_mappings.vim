" Mappings example for use with gdb
" Maintainer:	<xdegaye at users dot sourceforge dot net>
" Last Change:	Mar 6 2006

if ! has("gdb")
    finish
endif

let s:gdb_k = 1
function! ToggleGDB()
    if getwinvar(0,'&statusline') != ""
        " :set autochdir
        " :cd %:p:h
        :only
        " set statusline=
        :call <SID>Toggle()
    else
        " set statusline+=%F%m%r%h%w\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]
        " :set noautochdir
        :call <SID>Toggle()
    endif
endfunction

function! SToggleGDB()
    :MiniBufExplorer
    set statusline+=%F%m%r%h%w\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]
    :call <SID>Toggle()
endfunction
nnoremap <F10>  :call ToggleGDB()<cr>
nnoremap <S-F10>  :call <SID>Toggle()<cr>

" nnoremap <S-F7>  :call SToggleGDB()<cr>
" nnoremap <C-F7>  :call <SID>Toggle()<CR>

" Toggle between vim default and custom mappings
function! s:Toggle()
    if s:gdb_k
	let s:gdb_k = 0
	nnoremap <Space> :call gdb("")<CR>
	nnoremap <silent> <C-Z> :call gdb("\032")<CR>

	nnoremap <silent> B :call gdb("info breakpoints")<CR>
	nnoremap <silent> L :call gdb("info locals")<CR>
	nnoremap <silent> A :call gdb("info args")<CR>
	nnoremap <silent> S :call gdb("step")<CR>
	nnoremap <silent> I :call gdb("stepi")<CR>
	nnoremap <silent> <C-N> :call gdb("next")<CR>
	nnoremap <silent> X :call gdb("nexti")<CR>
	nnoremap <silent> F :call gdb("finish")<CR>
	nnoremap <silent> R :call gdb("run")<CR>
	nnoremap <silent> Q :call gdb("quit")<CR>
	nnoremap <silent> C :call gdb("continue")<CR>
	nnoremap <silent> W :call gdb("where")<CR>
	nnoremap <silent> <C-U> :call gdb("up")<CR>
	nnoremap <silent> <C-D> :call gdb("down")<CR>

	" set/clear bp at current line
	nnoremap <silent> <C-B> :call <SID>Breakpoint("break")<CR>
	nnoremap <silent> <F9> :call <SID>Breakpoint("clear")<CR>
	nnoremap <silent> <C-F9> :call <SID>Breakpoint("disable")<CR>

	" print value at cursor
	nnoremap <silent> <C-P> :call gdb("print " . expand("<cword>"))<CR>

	" display Visual selected expression
	vnoremap <silent> <C-P> y:call gdb("createvar " . "<C-R>"")<CR>

	" print value referenced by word at cursor
	nnoremap <silent> <C-Y> :call gdb("print *" . expand("<cword>"))<CR>

	set iskeyword+=45,46,62

	echohl ErrorMsg
	echo "gdb keys mapped"
	echohl None

    " Restore vim defaults
    else
	let s:gdb_k = 1
	nunmap <Space>
	nunmap <C-Z>

	nunmap B
	nunmap L
	nunmap A
	nunmap S
	nunmap I
	nunmap <C-N>
	nunmap X
	nunmap F
	nunmap R
	nunmap Q
	nunmap C
	nunmap W
	nunmap <C-U>
	nunmap <C-D>

	nunmap <C-B>
	nunmap <F9>
	nunmap <C-F9>
	nunmap <C-P>
	nunmap <C-Y>

	" restore custom mappings
	noremap <C-n> :BufSurfForward<CR>
	noremap <C-p> :BufSurfBack<CR>

	set iskeyword-=45,46,62

	echohl ErrorMsg
	echo "gdb keys reset to default"
	echohl None
    endif
endfunction

" Run cmd on the current line in assembly or symbolic source code
" parameter cmd may be 'break' or 'clear'
function! s:Breakpoint(cmd)
    " An asm buffer (a 'nofile')
    if &buftype == "nofile"
	" line start with address 0xhhhh...
	let s = substitute(getline("."), "^\\s*\\(0x\\x\\+\\).*$", "*\\1", "")
	if s != "*"
	    call gdb(a:cmd . " " . s)
	endif
    " A source file
    else
	let s = "\"" . fnamemodify(expand("%"), ":p") . ":" . line(".") . "\""
	call gdb(a:cmd . " " . s)
    endif
endfunction

" map vimGdb keys
"call s:Toggle()


