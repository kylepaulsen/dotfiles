"===== Try to auto install plugins ====="
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"===== Run :PlugInstall to install plugins! =====
call plug#begin()
Plug 'tpope/vim-sleuth' "Tries to auto detect indentation of file
Plug 'pangloss/vim-javascript' "JS bundle for vim - provides syntax highlighting and improved indentation.
Plug 'nathanaelkane/vim-indent-guides' "plugin for visually displaying indent levels.
Plug 'roxma/vim-paste-easy' "plugin for fixing vim's stupid auto indent paste crap.
Plug 'scrooloose/nerdcommenter' "Comment functions so powerful—no comment necessary.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fuzzy finder plugin
call plug#end()


"===== General Settings ====="

colorscheme koehler

set nocompatible "makes vim abandon being vi compatible for more features
set encoding=UTF-8
set incsearch "highlight matches while typing search regex
set wrap "turns wordwrap on. Shows "-->" on the left as a way to show a line wrapped.
set showbreak=--\> "how to show a line wrapped.
set number "show line numbers
set ignorecase "ignore case while searching
set hlsearch "highlight search matches
set tabstop=4 "how many spaces is a tab (\t) equal to visually (doesn't insert bytes)
set shiftwidth=4 "how large a tab is when using >> or << to indent existing code.
set textwidth=0 "dont auto-wrap text
"Show tab characters with an arrow
"set list lcs=tab:\➝\
set list
set listchars=tab:\➝\ ,trail:·

"changes cursor
"let &t_SI = "\e[3 q"
"let &t_EI = "\e[4 q"

"===== My Maps ====="
"<S-Tab> means Shift Tab
"<C-Tab> means Ctrl Tab

"Home key goes to beginning of text. Without these it goes past the indentation
nnoremap <Home> ^
inoremap <Home> <c-o>^

"sorta easy tabbing"
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
inoremap <Tab> <C-t>
inoremap <S-Tab> <C-d>

"bind ctrl y to redo
nnoremap <C-y> <C-r>

"bind ctrl z to undo
nnoremap <C-z> u

"shift+arrow selection
nnoremap <S-Up> v<Up>
nnoremap <S-Down> v<Down>
nnoremap <S-Left> <Left>v<Left>
nnoremap <S-Right> v<Right>
vnoremap <Up> <Esc><Up>
vnoremap <Down> <Esc><Down>
vnoremap <Left> <Esc><Left>
vnoremap <Right> <Esc><Right>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
inoremap <S-Up> <Esc>v<Up>
inoremap <S-Down> <Esc><Right>v<Down>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc><Right>v<Right>

"shift home, shift end selection
nnoremap <S-Home> v^
nnoremap <S-End> v<End>
vnoremap <S-Home> ^
vnoremap <S-End> <End>
vnoremap <Home> <Esc>^
vnoremap <End> <Esc><End>
inoremap <S-Home> <Esc>v^
inoremap <S-End> <Esc><Right>v<End>

"fix paste
nnoremap p P<Right>

"ctrl left, ctrl right jump over words
nnoremap <C-Left> b
nnoremap <C-Right> e
"dont want these bindings otherwise makes block visual hard to use.
"vnoremap <C-Left> b
"vnoremap <C-Right> e
inoremap <C-Left> <Esc>bi
inoremap <C-Right> <Esc>ei

"ctrl alt up, ctrl alt down to move lines
nnoremap <C-A-Up> dd<Up>P
nnoremap <C-A-Down> dd<Down>P
inoremap <C-A-Up> <Esc>dd<Up>Pi
inoremap <C-A-Down> <Esc>dd<Down>Pi
"visual mode multiline moving
xnoremap <C-A-Up> :m-2<CR>gv=gv
xnoremap <C-A-Down> :m'>+<CR>gv=gv

"ctrl up, ctrl down for block visual
nnoremap <C-Up> <C-v>k
nnoremap <C-Down> <C-v>j
vnoremap <C-Up> <Up>
vnoremap <C-Down> <Down>
vnoremap <C-Right> <Right>
vnoremap <C-Left> <Left>

"i in visual mode is S-i for multiline edit
vnoremap i I

"clear search highlights when starting new search.
nnoremap / :let @/ = ""<CR>/

"Stop Esc in insert mode moving the cursor left
autocmd InsertLeave * :normal! `^
set virtualedit=onemore

"Backspace in visual mode deltes
vnoremap <Backspace> <Delete>

"Ctrl T opens new tab
nnoremap <C-t> :tabnew<CR>

"tab navigation with alt left and right
nnoremap <A-Left> :tabprevious<CR>
nnoremap <A-Right> :tabnext<CR>

"VSCode ctrl-d binding. Highlight what you want to replace in visual mode or
"with a search, then Ctrl-D to start replacing. When back in normal mode,
"Ctrl-D will just repeat the replace you just did.
vnoremap <C-d> y/<C-r>"<CR><S-n>cgn
cnoremap <C-d> <CR>cgn
nnoremap <C-d> .<Right>


"===== Custom Commands ====="

function Indent(...)
    let type = get(a:, 1, "tab")
    let len = get(a:, 2, 4)
    if type =~ "tab"
        set noexpandtab
    else
        set expandtab
    endif
    let &tabstop=len
    let &shiftwidth=len
    set autoindent
endfunction

command! -nargs=* Indent call Indent(<f-args>)


"===== Plugin Settings ====="

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236

let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle
imap <C-_> <Esc><plug>NERDCommenterToggle i

"Ctrl-p to open fuzzy file opener. Ctrl-T to open in new tab. Ctrl-V to open vertical split.
nnoremap <C-p> :FZF<CR>
" fun! SetupCommandAlias(from, to)
"   exec 'cnoreabbrev <expr> '.a:from
"         \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
"         \ .'? ("'.a:to.'") : ("'.a:from.'"))'
" endfun
" call SetupCommandAlias("o","FZF")

au! BufWritePost .vimrc source ~/.vimrc

