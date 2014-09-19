" behave like windows
" source $VIMRUNTIME/mswin.vim

" source .vimrc from any directory you run vim from
set exrc

" Remove ALL autocommands for the current group.
autocmd! 

" restrict usage of some commands in non-default .vimrc files; commands that
" wrote to file or execute shell commands are not allowed and map commands are
" displayed.
" set secure
"
execute pathogen#infect()

syntax on
colorscheme desert

set number
set ruler
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show cursor at beinning of tab in normal mode
set list lcs=tab:\ \ 

" bind unamed register to system clipboard
set clipboard=unnamedplus

" Ctrl-a to select all 
noremap <C-a> <ESC>ggVG

set smartcase

" setup vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" Bundle 'gmarik/vundle'

"my Bundle here:
"
" original repos on github


"my Bundle here:
"
" original repos on github
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

" autocomplete for [] () and so on
" Bundle 'Raimondi/delimitMate'

"..................................
" vim-scripts repos
" Bundle 'YankRing.vim'
" Bundle 'vcscommand.vim'
" Bundle 'ShowPairs'
" Bundle 'SudoEdit.vim'
" Bundle 'EasyGrep'
" Bundle 'VOoM'
" Bundle 'VimIM'
"..................................
" non github repos
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

" gvim settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" leader settings
let mapleader = ","
let g:mapleader = ","

" fswitch
" Bundle 'fswitch'
noremap <leader>a <ESC>:FSHere<CR>

" buffer related settings

" any buffer can be hidden (keeping its changes) without
" first writing the buffer to a file
set hidden

"  tell Vim to abandon a buffer but you have unsaved changes, Vim will ask you
"  whether to save your changes first, abandon them, or cancel the action.
"  set confirm

" fast way to switch between buffer
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

" close current buffer
nnoremap <Leader>q :q<CR>
nnoremap <C-S> :w<CR>

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

nnoremap <silent><F2> :NERDTreeToggle<cr>
imap <F2> <Esc>:NERDTreeToggle<cr>

" auto open NERDTree when start
" autocmd VimEnter * NERDTree
" wincmd w
" move cursor from NERDTree to file
" autocmd VimEnter * wincmd w 

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore=['\.o$', '\.ko$', '\.symvers$', '\.order$', '\.mod.c$', '\.swp$', '\.bak$', '\~$']
" let NERDTreeSortOrder=['\/$', 'Makefile', 'makefile', '\.c$', '\.cc$', '\.cpp$', '\.h$', '*', '\~$']
" let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=0
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 31

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
" let g:miniBufExplBuffersNeeded = 0
" let g:miniBufExplCycleArround = 1
" let g:miniBufExplMinSize = 1 
" let g:miniBufExplUseSingleClick = 1 " single click to open buffer
" neend tree on bottom, else it will conflict with vimgdb
" let g:miniBufExplSplitBelow = 0  
let g:miniBufExplorerAutoStart = 0

" not work because these keys is intercepted by terminal
" noremap <C-TAB> :MBEbn<CR>
" noremap <C-S-TAB> :MBEbp<CR>
" noremap <C-PageDown> :MBEbn<CR>
" noremap <C-PageUp> :MBEbp<CR>

" YouCompleteMe settings
" Bundle 'Valloric/YouCompleteMe'

" loading extra configs for YCM
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>y :YcmDiags<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_show_diagnostics_ui = 1

" Bundle 'scrooloose/syntastic'

" Bundle 'tpope/vim-fugitive.git'

" vimgdb
set previewheight=12		" set gdb window initial height
run macros/gdb_mappings.vim	" source key mappings listed in this document
set asm=0				" don't show any assembly stuff

" Bundle 'vim-maximizer'
nnoremap <silent><leader>x :MaximizerToggle<CR>
vnoremap <silent><leader>x :MaximizerToggle<CR>gv
inoremap <silent><leader>x <C-o>:MaximizerToggle<CR>

" Bundle 'wesQ3/vim-windowswap'
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>wy :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>wp :call WindowSwap#DoWindowSwap()<CR>

" increase the window size by a factor of 1.5 and decrease the 
" window size by 0.67, you can map this
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

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
nnoremap <silent><leader>r  :cscope find c <C-r>=expand("<cword>")<CR><CR>
nnoremap <silent><leader>t  :cscope find t <C-r>=expand("<cword>")<CR><CR>
nnoremap <silent><leader>c  :scscope find c <C-r>=expand("<cword>")<CR><CR>
nnoremap <silent><leader>vc :vert scscope find c <C-r>=expand("<cword>")<CR><CR>

" buffer explorer
" Bundle 'jlanzarotta/bufexplorer'

nnoremap <silent><F3> :BufExplorerHorizontalSplit<CR>

" tag list
" Bundle 'vim-scripts/taglist.vim'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Auto_Open = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 0  
noremap <silent><F4> :TlistToggle<CR>

" conque-shell
" Bundle 'oplatek/Conque-Shell'
noremap <silent><leader>u :ConqueTermSplit bash<CR>

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
" airline theme
" Bundle 'paranoida/vim-airlineish'
let g:airline_theme = 'airlineish'

" move like in bash
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>

" open last buffer
noremap <C-e> :e#<CR>
noremap <C-n> :bnext<CR>
noremap <C-p> :bprev<CR>

" show different color in css file
" Bundle 'skammer/vim-css-color'

" highlight search configs
set hlsearch
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline
noremap <F12> :set hlsearch! hlsearch?<CR>

" toggle quick fix window
if has('quickfix') 
	set cscopequickfix=s-,c-,d-,i-,t-,e- 
endif
noremap <silent><leader>n :cnext<CR>
noremap <silent><leader>p :cprev<CR>
" noremap <silent><leader>o :botright copen<CR>

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

nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>o :call ToggleList("Quickfix List", 'c')<CR>

" make vim dont indent pasted text
set paste	

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

