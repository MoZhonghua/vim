" source .vimrc from any directory you run vim from
set exrc

" Remove ALL autocommands for the current group.
autocmd!

if has("win32")
    " behave like windows
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" leader settings
let mapleader = ","
let g:mapleader = ","

" ======================================================================
" generic configurations
" ======================================================================
syntax on
set number
set ruler
" set cindent
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
" :retab to replace existing tabs with space
set expandtab
set smartcase

" tags
set tags=./tags;../tags;../../tags;../../../tags;../../../../tags;../../../../../tags

" easy way to move between window
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l
noremap <C-L> <C-W>l

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

" I never use Ex Mode, and it is very annoying
noremap Q <Nop>

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

" disable arrow key in vim, so you must move in vim-way
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" move in very long line
nnoremap j gj
nnoremap k gk

" show error when text length exceeds 120
" colorcolumn is only available after Vim 7.3
"
" match ErrorMsg '\%>120v.\+'

if !has('win32')
    " font and colorscheme
    colorscheme desert
    set guifont=Monospace\ 11

    " gvim settings
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    " show cursor at beinning of tab in normal mode
    set list lcs=tab:\ \ 

    " Ctrl-a to select all
    noremap <C-a> <ESC>ggVG

    " This will not work if you login with normal user but
    " run vim as root
    set clipboard=unnamedplus
else
    colorscheme desert
    set guifont=Consolas:h12:cANSI

        " bind unamed register to system clipboard
        " ref http://stackoverflow.com/questions/8757395/can-vim-use-the-system-clipboards-by-default
    set clipboard+=unnamed,unnamedplus
endif

" backspace
set backspace=indent,eol,start

" F8 to make
inoremap <F8> <ESC>:make<CR>
nnoremap <F8> :make<CR>
" <C-F8> to update tags of current file, :pwd should be where old tags 
" file locates in
nnoremap <C-F8> :!ctags -a %<CR>

" scroll to top but not at the first line, but the second line
nnoremap zt ztkj
nnoremap zb zbjk

" A longer line will be broken after white space to get this width. A zero value 
" disables this. 
" ref :help textwidth
set textwidth=80

" see :help gF
nnoremap gf gF

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

" use :e! to discard undo history when you get a known good point, for example,
" after you commit changes.
if v:version >= 703
    set undoreload=0
endif

set fileencodings=utf-8,ucs-bom,gbk,default,latin1

" toggle set paste
noremap <leader>u :set paste!<CR>

" increase the window size by a factor of 1.5 and decrease the
" window size by 0.67, you can map this
" nnoremap  <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap  <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap  <Leader>+ :resize +3<CR>
nnoremap  <Leader>- :resize -3<CR>

" use shorter updatetime to trigger |CursorHold| autocommand event
set updatetime=1000

" move like bash in command mode
" C-w delete last work
" C-u delete whole  line
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>


" ======================================================================
" highlight settings
" ======================================================================
" Put cursor on the word and press <F10> to get which HI group current word
" belongs to
map <leader>j :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" highlight search configs
set hlsearch
set incsearch
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline
hi Search guifg=Yellow guibg=NONE gui=bold,underline
noremap <leader>h :set hlsearch! hlsearch?<CR>

" ======================================================================
" quick-fix
" ======================================================================
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


" ======================================================================
" cscope settings
" ======================================================================
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
nnoremap <leader>t  :cscope find s <C-r>=expand("<cword>")<CR><CR>
nnoremap <leader>g  :cscope find g <C-r>=expand("<cword>")<CR><CR>
" nnoremap <leader>c  :scscope find c <C-r>=expand("<cword>")<CR><CR>
" nnoremap <leader>vc :vert scscope find c <C-r>=expand("<cword>")<CR><CR>
if has('win32')
    set cscopeprg=E:\kuaipan_kasulle\tools\cscope.exe
endif

" ======================================================================
" Buffer related configurations
" ======================================================================

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

" restrict usage of some commands in non-default .vimrc files; commands that
" wrote to file or execute shell commands are not allowed and map commands are
" displayed.
" set secure

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

" ======================================================================
" Qgrep: a custom grep tool
" ======================================================================
" run external grep, :grep is very slow with YCM
function! Qgrep(str, mark)
    let l:cmd = "grep -rnFI --include='*.[ch]' --include='*.cc' --include='*.cpp'" . " " . a:str . " ."
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
" nnoremap <leader>g :call Qgrep(expand('<cword>'), 'Z')<CR>
" nnoremap <leader>Ga :call Qgrep(expand('<cword>'), 'A')<CR>
" nnoremap <leader>Gb :call Qgrep(expand('<cword>'), 'B')<CR>
" nnoremap <leader>Gc :call Qgrep(expand('<cword>'), 'C')<CR>

" ======================================================================
" vimgdb settings
" ======================================================================
" vimgdb
if has("gdb")
    set previewheight=12                " set gdb window initial height
    run macros/gdb_mappings.vim " source key mappings listed in this document
    set asm=0                           " don't show any assembly stuff
endif

nnoremap <F12> :set iskeyword+=45,46,62<CR>
nnoremap <S-F12> :set iskeyword-=45,46,62<CR>

" ======================================================================
" Pathogen - deprecatd, use vundle to manage plugins
" ======================================================================
" To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = []

" call add(g:pathogen_disabled, 'vim-airline')
" if has('win32')
"     call add(g:pathogen_disabled, 'YouCompleteMe')
"     call add(g:pathogen_disabled, 'vim-autotag')
"     execute pathogen#infect('~\.vim\bundle\{}')
" else
"     if !has('python') || v:version < 703
"       call add(g:pathogen_disabled, 'YouCompleteMe')
"     endif
"     execute pathogen#infect()
" endif

" ======================================================================
" setup vundle
" ======================================================================
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'fholgado/minibufexpl.vim'
Plugin 'bling/vim-airline'
Plugin 'bogado/file-line'
Plugin 'fatih/vim-go'
Plugin 'fswitch'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'kien/ctrlp.vim'
Plugin 'paranoida/vim-airlineish'
Plugin 'scrooloose/nerdtree'
Plugin 'skammer/vim-css-color'
Plugin 'ton/vim-bufsurf'
Plugin 'vim-maximizer'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fidian/hexmode'

if !has('win32')
        " AutoTag will cause gvim crash in Windows
        Plugin 'vim-scripts/AutoTag'

        " starify may block vim in win32
        Plugin 'mhinz/vim-startify'

        " check whether we can enable YCM
        if has('python') && v:version > 703
                Plugin 'Valloric/YouCompleteMe'
        endif
endif

call vundle#end()

"......................................
filetype plugin indent on

" ======================================================================
" fswitch
" ======================================================================
nnoremap <leader>a <ESC>:FSHere<CR>
inoremap  <F1> <ESC>:FSHere<CR>
nnoremap  <F1> <ESC>:FSHere<CR>

au! BufEnter *.c    let b:fswitchdst = 'h'          | let b:fswitchlocs="."
au! BufEnter *.cc   let b:fswitchdst = 'h,hpp'      | let b:fswitchlocs="."
au! BufEnter *.cpp  let b:fswitchdst = 'h,hpp'      | let b:fswitchlocs="."
au! BufEnter *.h    let b:fswitchdst = 'c,cc,cpp'   | let b:fswitchlocs="."
au! BufEnter *.hpp  let b:fswitchdst = 'cc,cpp'     | let b:fswitchlocs="."

" disable alternative file creation
let fsnonewfiles=0

" ======================================================================
" NERDTree
" ======================================================================
nnoremap <F4> :NERDTreeToggle<cr>
imap <F4> <Esc>:NERDTreeToggle<cr>
noremap <leader>c :NERDTreeFind<cr><c-w><c-p>

if !has('win32') 
        " auto open NERDTree when start
        autocmd VimEnter * NERDTree
        wincmd w
        " move cursor from NERDTree to file
        autocmd VimEnter * wincmd w
endif

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
                \ || l:fname ==? 'CMakeLists.txt'
        return 1
    endif
    if l:extension ==? 'c' || l:extension ==? 'h' 
                \ || l:extension ==? 'am' || l:extension ==? 'cpp' 
                \ || l:extension ==? 'cc' || l:extension ==? 'sh'
                \ || l:extension ==? 'proto'
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
if !has('win32')
    " This will hang gvim for a long time
    autocmd BufEnter * call rc:syncTree()
endif

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeIgnore=['\.o$', '\.ko$', '\.symvers$', '\.order$', '\.mod.c$', '\.swp$', '\.bak$', '\~$']
" let NERDTreeSortOrder=['\/$', 'Makefile', 'makefile', '\.c$', '\.cc$', '\.cpp$', '\.h$', '*', '\~$']
" let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=0
let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 31
let NERDTreeShowBookmarks = 1

" ======================================================================
" CtrlP for file searching
" ======================================================================
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


" ======================================================================
" minibufexpl
" ======================================================================
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


" ======================================================================
" YouCompleteMe
" ======================================================================

" loading extra configs for YCM
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
nnoremap <silent><leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>y :YcmDiags<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_show_diagnostics_ui = 1
" let g:ycm_extra_conf_globlist = ['./*']

" ======================================================================
" vim-maximizer
" ======================================================================
nnoremap <leader>x :MaximizerToggle<CR>
vnoremap <leader>x :MaximizerToggle<CR>gv
" since we use space as leader key, so we should not create any
" mapping in insert mode
" inoremap <leader>x <C-o>:MaximizerToggle<CR>

" ======================================================================
" buffer explorer
" ======================================================================

" nnoremap <F3> :BufExplorerHorizontalSplit<CR>

" ======================================================================
" tag list
" ======================================================================
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Auto_Open = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 1
let Tlist_Use_Right_Window = 0
noremap <F2> :TlistToggle<CR>
inoremap <F2> <ESC>:TlistToggle<CR>

" ======================================================================
" vim-airline
" ======================================================================
let g:airline_theme = 'airlineish'
let g:airline#extensions#tabline#enabled = 1

" show relative path to current working dir
let g:airline_section_c = '%f'

" disable warning field, so we have more space to show file path
let g:airline_section_warning=""

" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_alt_sep = '|'

" ======================================================================
" show different color in css file
" ======================================================================


" ======================================================================
" YankRing
" ======================================================================
nnoremap <C-F12> :YRShow<CR>

let g:yankring_replace_n_pkey = ''
let g:yankring_replace_n_nkey = ''

" ======================================================================
" bufkill: kill buffer without closing window
" ======================================================================

" ======================================================================
" Buffer suf: switch buffer according edit history
" ======================================================================

" Vim default bnext/bprevious will jump between buffer according
" the order of opening buffer
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


" ======================================================================
" vim-startify
" ======================================================================
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 0

" ======================================================================
" file-line
" ======================================================================
" :open file:123

" ======================================================================
" vim-go
" ======================================================================


" ======================================================================
" vim-markdown && vim-flavored-markdown
" ======================================================================
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END


" ======================================================================
" altercation/vim-colors-solarized
" ======================================================================
if !has('win32')
    syntax on
    set background=dark
    let g:solarized_termcolors=16
    " Must set to 1, else highlighting text will have wired background color
    let g:solarized_termtrans = 1
    colorscheme solarized
    " NERDTree use CursorLine to identify current file
    " 8 is invalid color index: palette with 16 colors, 8 fg and 8 bg, 
    " so valid index is [0-7]
    hi CursorLine cterm=underline gui=underline
endif

colorscheme desert
set background=dark
