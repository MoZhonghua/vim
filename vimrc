" source .vimrc from any directory you run vim from
set exrc

" Remove ALL autocommands for the current group.
autocmd!

if has("win32")
	" behave like windows
	source $VIMRUNTIME/mswin.vim
	behave mswin
endif

" restrict usage of some commands in non-default .vimrc files; commands that
" wrote to file or execute shell commands are not allowed and map commands are
" displayed.
" set secure
"

syntax on


" font and colorscheme
if !has('win32')
	colorscheme desert
	set guifont=Monospace\ 11
else
	colorscheme desert
	set guifont=Consolas:h12:cANSI
endif

set number
set ruler
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

if !has("win32")
	" show cursor at beinning of tab in normal mode
	set list lcs=tab:\ \ 

	" Ctrl-a to select all
	noremap <C-a> <ESC>ggVG
endif

" bind unamed register to system clipboard
" ref http://stackoverflow.com/questions/8757395/can-vim-use-the-system-clipboards-by-default

if has('win32')
	set clipboard+=unnamed,unnamedplus
else
	" This will not work if you login with normal user but
	" run vim as root
	set clipboard=unnamedplus
endif

set smartcase

" setup vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

" delimitMate is very anoying
call add(g:pathogen_disabled, 'delimitMate')
call add(g:pathogen_disabled, 'vim-scroll-position')
call add(g:pathogen_disabled, 'autosession.vim')
call add(g:pathogen_disabled, 'VimIM')
call add(g:pathogen_disabled, 'vim-powerline')
" call add(g:pathogen_disabled, 'vim-airline')

if has('win32')
	call add(g:pathogen_disabled, 'YouCompleteMe')
	execute pathogen#infect('~\vimfiles\bundle\{}')
else
	execute pathogen#infect()
endif

" set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" Bundle 'gmarik/vundle'
" Bundle 'kien/ctrlp.vim'
" Bundle 'sukima/xmledit'
" Bundle 'sjl/gundo.vim'
" Bundle 'jiangmiao/auto-pairs'
" Bundle 'klen/python-mode'
" Bundle 'Valloric/ListToggle'
" Bundle 'SirVer/ultisnips'
" Bundle 'scrooloose/syntastic'
" Bundle 't9md/vim-quickhl'
" Bundle 'Lokaltog/vim-powerline'
" Bundle 'scrooloose/nerdcommenter'
" Bundle 'Raimondi/delimitMate'
" Bundle 'YankRing.vim'
" Bundle 'vcscommand.vim'
" Bundle 'ShowPairs'
" Bundle 'SudoEdit.vim'
" Bundle 'EasyGrep'
" Bundle 'VOoM'
" Bundle 'VimIM'
" Bundle 'git://git.wincent.com/command-t.git'

"......................................
filetype plugin indent on

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

if !has('win32')
	" gvim settings
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
endif

" leader settings
let mapleader = ","
let g:mapleader = ","

" fswitch
" Bundle 'fswitch'
nnoremap <leader>a <ESC>:FSHere<CR>
inoremap  <F1> <ESC>:FSHere<CR>
nnoremap  <F1> <ESC>:FSHere<CR>

" buffer related settings

" any buffer can be hidden (keeping its changes) without
" first writing the buffer to a file
set hidden

"  tell Vim to abandon a buffer but you have unsaved changes, Vim will ask you
"  whether to save your changes first, abandon them, or cancel the action.
"  set confirm

" close current buffer
nnoremap <Leader>q :q<CR>
nnoremap <leader>d :BD<CR>
nnoremap <Leader>w :w<CR>

" tags
set tags=./tags;../tags;../../tags;../../../tags;../../../../tags;../../../../../tags


" map Y "+y
" map P "+p  ""

" easy way to move between window
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l
noremap <C-L> <C-W>l


" show error when text length exceeds 120
" colorcolumn is only available after Vim 7.3
"
" match ErrorMsg '\%>120v.\+'

" NERDTree
" Bundle 'scrooloose/nerdtree'

nnoremap <F4> :NERDTreeToggle<cr>
imap <F4> <Esc>:NERDTreeToggle<cr>
noremap <leader>c :NERDTreeFind<cr><c-w><c-p>

" auto open NERDTree when start
" autocmd VimEnter * NERDTree
" wincmd w
" move cursor from NERDTree to file
" autocmd VimEnter * wincmd w

" Check if NERDTree is open or active
function! rc:isNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" check if current buffer is under working directory
function! rc:isFileInsideCurrentDir()
	return expand('%:p:.') != expand('%:p')
endfunction

function! rc:isInterestingFile()
	let l:fname = expand('%')
	let l:extension =  expand('%:e')
	if l:fname ==? 'makefile' || l:fname ==? 'configure'
		return 1
	endif
	if l:extension ==? 'c' || l:extension ==? 'h' 
				\ || l:extension ==? 'am' || l:extension ==? 'cpp' 
				\ || l:extension ==? 'cc' || l:extension ==? 'sh'
		return 1
	endif 
	return 0
endfunction

let g:sync_tree_auto_enable = 1

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! rc:syncTree()
	if g:sync_tree_auto_enable == 0
		return
	endif
    if &modifiable && rc:isNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
	if rc:isInterestingFile() && rc:isFileInsideCurrentDir()
	    NERDTreeFind
	    execute "normal! zz"
	    if expand('%') =~ 'NERD_tree'
		wincmd p
	    endif
	endif
    endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call rc:syncTree()

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore=['\.o$', '\.ko$', '\.symvers$', '\.order$', '\.mod.c$', '\.swp$', '\.bak$', '\~$']
" let NERDTreeSortOrder=['\/$', 'Makefile', 'makefile', '\.c$', '\.cc$', '\.cpp$', '\.h$', '*', '\~$']
" let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=0
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 31
let NERDTreeShowBookmarks = 1

" CtrlP for file searching
" Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(o|ko|so|obj|dll|exe|la|status)$',
\ 'link': 'some_bad_symbolic_links',
\ }
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_files = 0
" search by file name only
let g:ctrlp_by_filename = 1

" show search window on top
let g:ctrlp_match_window = 'top'

" Bundle "fholgado/minibufexpl.vim"
let g:miniBufExplBuffersNeeded = 0
let g:miniBufExplCycleArround = 1
let g:miniBufExplMinSize = 1
let g:miniBufExplUseSingleClick = 1 " single click to open buffer
" neend tree on bottom, else it will conflict with vimgdb
let g:miniBufExplSplitBelow = 0
let g:miniBufExplorerAutoStart = 0

nnoremap <F3> :MBEToggle<CR>
inoremap <F3> <ESC>:MBEToggle<CR>

" not work because these keys is intercepted by terminal
" noremap <C-TAB> :MBEbn<CR>
" noremap <C-S-TAB> :MBEbp<CR>
" noremap <C-PageDown> :MBEbn<CR>
" noremap <C-PageUp> :MBEbp<CR>

" YouCompleteMe settings
" Bundle 'Valloric/YouCompleteMe'

" loading extra configs for YCM
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
nnoremap <silent><leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>y :YcmDiags<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_show_diagnostics_ui = 1
" let g:ycm_extra_conf_globlist = ['./*']

" Bundle 'scrooloose/syntastic'

" Bundle 'tpope/vim-fugitive.git'

" vimgdb
if has("gdb")
	set previewheight=12		" set gdb window initial height
	run macros/gdb_mappings.vim	" source key mappings listed in this document
	set asm=0				" don't show any assembly stuff
endif

" Bundle 'vim-maximizer'
nnoremap <leader>x :MaximizerToggle<CR>
vnoremap <leader>x :MaximizerToggle<CR>gv
" since we use space as leader key, so we should not create any
" mapping in insert mode
" inoremap <leader>x <C-o>:MaximizerToggle<CR>

" Bundle 'wesQ3/vim-windowswap'
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap  <leader>Wy :call WindowSwap#MarkWindowSwap()<CR>
nnoremap  <leader>Wp :call WindowSwap#DoWindowSwap()<CR>

" increase the window size by a factor of 1.5 and decrease the
" window size by 0.67, you can map this
nnoremap  <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap  <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" cscope settings copied from help
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

" cscope key maps
nnoremap <leader>r  :cscope find c <C-r>=expand("<cword>")<CR><CR>
nnoremap <leader>t  :cscope find t <C-r>=expand("<cword>")<CR><CR>
" nnoremap <leader>c  :scscope find c <C-r>=expand("<cword>")<CR><CR>
" nnoremap <leader>vc :vert scscope find c <C-r>=expand("<cword>")<CR><CR>

" buffer explorer
" Bundle 'jlanzarotta/bufexplorer'

" nnoremap <F3> :BufExplorerHorizontalSplit<CR>

" tag list
" Bundle 'vim-scripts/taglist.vim'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Auto_Open = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 0
noremap <F2> :TlistToggle<CR>

" use shorter updatetime to trigger |CursorHold| autocommand event
set updatetime=1000

" conque-shell
" Bundle 'oplatek/Conque-Shell'
noremap <leader>u :ConqueTermSplit bash<CR>

" Power line
" Bundle 'Lokaltog/vim-powerline'
set encoding=utf-8
set laststatus=2
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
" clobber
" let g:Powerline_symbols = 'unicode'
" let g:Powerline_symbols = 'fancy'

" Bundle 'bling/vim-airline'
" Bundle 'paranoida/vim-airlineish'
let g:airline_theme = 'airlineish'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_alt_sep = '|'

" move like bash in command mode
" C-w delete last work
" C-u delete whole  line
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>

" show different color in css file
" Bundle 'skammer/vim-css-color'

" highlight search configs
set hlsearch
set incsearch
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline
hi Search guifg=Yellow guibg=NONE gui=bold,underline
noremap <leader>h :set hlsearch! hlsearch?<CR>

" toggle quick fix window
if has('quickfix')
	set cscopequickfix=s-,c-,d-,i-,t-,e-
endif
noremap <leader>n :cnext<CR>
noremap <leader>p :cprev<CR>
" noremap <leader>o :botright copen<CR>

function! GetBufferList()
	redir =>buflist
	silent! ls
	redir END
	return buflist
endfunction

function! ToggleList(bufname, pfx)
	let buflist = GetBufferList()
	for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
		if bufwinnr(bufnum) != -1
			exec(a:pfx.'close')
			return
		endif
	endfor
	if a:pfx == 'l' && len(getloclist(0)) == 0
		echohl ErrorMsg
		echo "Location List is Empty."
		return
	endif
	let winnr = winnr()
	exec('botright '.a:pfx.'open')
	if winnr() != winnr
		wincmd p
	endif
endfunction

nnoremap  <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap  <leader>o :call ToggleList("Quickfix List", 'c')<CR>

" make vim do not indent pasted text
" you should only disable it temporarily when paste large text
" else auto-indent function will not work
set nopaste	

" expand %% to %:h in command mode
" not work, some configs conflicts with this, but I don't know which
" cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

" fix delay when exit visaul mode
set timeoutlen=1000
set ttimeoutlen=0

" show Ex command in another tab
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" use \v for very magic and \V for very nomagic
" default is magic mode, that is:
"  . * [ ]     special meaning but
"  [^_a-zA-z0-9] will match literally, such as ( ) { } + | ?
set nomagic

" a quick way to edit vimrc
if !has('win32')
	noremap <leader>rc :e ~/.vimrc<CR>
else
	noremap <leader>rc :e ~\_vimrc<CR>
endif

" use ; to enter command mode
" noremap ; :

" disable arrow key in vim, so you must move in vim-way
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" move in very long line
nnoremap j gj
nnoremap k gk

" YankRing
" Bundle 'vim-scripts/YankRing.vim'
nnoremap <F12> :YRShow<CR>
" we use ctrl-p / ctrl-n to swith between buffer
let g:yankring_replace_n_pkey = ''
let g:yankring_replace_n_nkey = ''

" bufkill: kill buffer without closing window
" Bundle 'vim-scripts/bufkill.vim'

" set imdisable
" inoremap <ESC> <ESC>:set iminsert=0<CR>

" VimIM
" Bundle 'vim-scripts/VimIM'
" let g:vimim_cloud = 'google,sogou,baidu,qq'
" let g:vimim_map = 'tab_as_gi'
" let g:vimim_mode = 'dynamic'
" let g:vimim_mycloud = 0
" let g:vimim_plugin = 'C:/var/mobile/vim/vimfiles/plugin'
" let g:vimim_punctuation = 2
" let g:vimim_shuangpin = 0
" let g:vimim_toggle = 'pinyin,google,sogou'

" see http://vimim.googlecode.com/svn/vimim/vimim.html
let g:vimim_cloud = 'sogou'

" ctrl-\ to toggle input method
" or ctrl-_, both are ok
let g:vimim_map='c-bslash'

" Buffer suf: switch buffer according edit history
" Vim default bnext/bprevious will jump between buffer according
" the order of opening buffer
" Bundle 'ton/vim-bufsurf'
"
" nnoremap <Leader>l :ls<CR>
" nnoremap <Leader>b :bp<CR>
" nnoremap <Leader>f :bn<CR>
" nnoremap <Leader>g :e#<CR>

noremap <C-p> :BufSurfBack<CR>
noremap <C-n> :BufSurfForward<CR>

noremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

" backspace
set backspace=indent,eol,start

" Bundle 'keitheis/vim-scroll-position'
" vim-scroll-bar
" Default markers
let g:scroll_position_marker         = '>'
let g:scroll_position_visual_begin   = '^'
let g:scroll_position_visual_middle  = ':'
let g:scroll_position_visual_end     = 'v'
let g:scroll_position_visual_overlap = '<>'

" Additional markers disabled by default due to slow rendering
" let g:scroll_position_jump = '-'
" let g:scroll_position_change = 'x'
hi SignColumn                  ctermbg=232
hi ScrollPositionMarker        ctermfg=208 ctermbg=232
hi ScrollPositionVisualBegin   ctermfg=196 ctermbg=232
hi ScrollPositionVisualMiddle  ctermfg=196 ctermbg=232
hi ScrollPositionVisualEnd     ctermfg=196 ctermbg=232
hi ScrollPositionVisualOverlap ctermfg=196 ctermbg=232
hi ScrollPositionChange        ctermfg=124 ctermbg=232
hi ScrollPositionJump          ctermfg=131 ctermbg=232
let g:scroll_position_visual = 1

" F8 to make
inoremap <F8> <ESC>:make<CR>
nnoremap <F8> :make<CR>


" scroll to top but not at the first line, but the second line
nnoremap zt ztkj
nnoremap zb zbjk

" A longer line will be broken after white space to get this width. A zero value 
" disables this. 
" ref :help textwidth
set textwidth=90

" see :help gF
nnoremap gf gF

" Bundle 'mhinz/vim-startify'
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 0
 

" :open file:123
" Bundle 'bogado/file-line'

" run external grep, :grep is very slow with YCM
function! Qgrep(str, mark)
	let l:cmd = "grep -rnFI --include='*.[ch]'" . " " . a:str . " ."
	echohl ErrorMsg
	echo l:cmd
	" create a global mark, so we can jump back
	if a:mark != ""
		execute "mark " . a:mark
	endif
	:cexpr system(l:cmd)
endfunction
function! Qgrep1(str)
	call Qgrep(a:str, "Z")
endfunction
command! -nargs=+ -complete=command Qgrep call Qgrep1(<q-args>)
nnoremap <leader>g :call Qgrep(expand('<cword>'), 'Z')<CR>
nnoremap <leader>Ga :call Qgrep(expand('<cword>'), 'A')<CR>
nnoremap <leader>Gb :call Qgrep(expand('<cword>'), 'B')<CR>
nnoremap <leader>Gc :call Qgrep(expand('<cword>'), 'C')<CR>

" Unite and so on
" Bundle 'Shougo/unite.vim'
" Bundle 'Shougo/vimproc.vim'
" Bundle 'Shougo/neomru.vim'

set history=4000

" set langmenu=en_US.GBK    " sets the language of the menu (gvim)
" language en                 " sets the language of the messages / ui (vim)
" set the menu & the message to English
if has('win32')
	set langmenu=en_US
	let $LANG= 'en_US'
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" cscope in windows
if has('win32')
	set cscopeprg=E:\kuaipan_kasulle\tools\cscope.exe
endif

