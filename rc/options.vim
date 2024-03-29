"---------------------------------------------------------------------------
" Search:
"

" Ignore the case of normal letters.
set ignorecase
" If the search pattern contains upper case characters, override ignorecase
" option.
set smartcase

" Enable incremental search.
set incsearch
" Don't highlight search result.
set hlsearch

" Searches wrap around the end of the file.
set wrapscan


"---------------------------------------------------------------------------
" Edit:
"

" Smart insert tab setting.
set smarttab
" Exchange tab to spaces.
set expandtab
" Substitute <Tab> with blanks.
set tabstop=4
" Spaces instead <Tab>.
set softtabstop=4
" Autoindent width.
set shiftwidth=4
" Round indent by shiftwidth.
set shiftround

" Enable smart indent.
set autoindent smartindent

function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=4
  setlocal noexpandtab
endfunction

" Disable modeline.
set modelines=0
set nomodeline
autocmd MyAutoCmd BufRead,BufWritePost *.txt setlocal modelines=5 modeline

" Use clipboard register.

if has('mac')
  let g:clipboard = {
    \ 'name': 'pbcopy',
    \ 'copy': {
    \    '+': 'pbcopy',
    \    '*': 'pbcopy',
    \  },
    \ 'paste': {
    \    '+': 'pbpaste',
    \    '*': 'pbpaste',
    \ },
    \ 'cache_enabled': 0,
    \ }
endif

if (!has('nvim') || $DISPLAY !=# '') && has('clipboard')
  if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
  else
     set clipboard& clipboard+=unnamed
  endif
endif

" Enable backspace delete indent and newline.
if has('patch-8.2.0592')
  set backspace=indent,eol,nostop
else
  set backspace=indent,eol,start
endif

" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
set hidden

" Search home directory path on cd.
" But can't complete.
"  set cdpath+=~

" Disable folding.
set nofoldenable
set foldmethod=manual
set foldlevel=3
" Show folding level.
if has('nvim-0.5')
  set foldcolumn=auto:1
else
  set foldcolumn=1
endif
set fillchars=vert:\|
set commentstring=%s

" FastFold
autocmd MyAutoCmd TextChangedI,TextChanged *
      \ if &l:foldenable && &l:foldmethod !=# 'manual' |
      \   let b:foldmethod_save = &l:foldmethod |
      \   let &l:foldmethod = 'manual' |
      \ endif
autocmd MyAutoCmd BufWritePost *
      \ if &l:foldmethod ==# 'manual' && exists('b:foldmethod_save') |
      \   let &l:foldmethod = b:foldmethod_save |
      \   execute 'normal! zx' |
      \ endif

if exists('*FoldCCtext')
  " Use FoldCCtext().
  set foldtext=FoldCCtext()
endif

" Use vimgrep.
" set grepprg=internal
" Use grep.
set grepprg=grep\ -inH

" Exclude = from isfilename.
set isfname-==

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=100

" Set swap directory.
set directory-=.

" Set undofile.
set undofile
let &g:undodir = &directory

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help.
set keywordprg=:help

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

if has('patch-8.1.0360')
  set diffopt=internal,algorithm:patience,indent-heuristic
endif

" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype ==# '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Use autofmt.
" set formatexpr=autofmt#japanese#formatexpr()

" Use blowfish2
" https://dgl.cx/2014/10/vim-blowfish
" if has('cryptv')
  " It seems 15ms overhead.
  "  set cryptmethod=blowfish2
" endif

" If true Vim master, use English help file.
set helplang& helplang=en,ja

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac


"---------------------------------------------------------------------------
" View:
"

" Show line number.
"set number
" Show <TAB> and <CR>
set list
if has('win32') || has('win64')
   set listchars=tab:>-,trail:-,precedes:<
else
   set listchars=tab:▸\ ,trail:-,precedes:«,nbsp:%
endif
" Always disable statusline.
set laststatus=0
" Height of command line.
set cmdheight=1
" Not show command on statusline.
" set noshowcmd
" Show title.
set title
" Title length.
set titlelen=95
" Title string.
let &g:titlestring = "
      \ %(%m%r%w%)%{expand('%:p:~:.')} %<\(%{fnamemodify(getcwd(), ':~')}\)"
" Disable tabline.
set showtabline=0

" Set statusline.
let &g:statusline = " %=%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}"

" Note: wrap option is very slow!
set nowrap
" Turn down a long line appointed in 'breakat'
set linebreak
set showbreak=\
set breakat=\ \	;:,!?
" Wrap conditions.
set whichwrap+=h,l,<,>,[,],b,s,~
set breakindent

" Do not display the greetings message at the time of Vim start.
" Do not display the completion messages
" Do not display the edit messages
set shortmess=aTIcF
set noshowmode

" Don't create backup.
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

" Disable bell.
set t_vb=
set novisualbell
set belloff=all

if has('nvim')
  " Display candidates by popup menu.
  set wildmenu
  set wildmode=full
  set wildoptions+=pum
else
  " Display candidates by list.
  set nowildmenu
  set wildmode=list:longest,full
endif
" Increase history amount.
set history=1000
" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag
" Can supplement a tag in a command-line.
set wildoptions+=tagfile

if has('nvim')
  set shada=!,'100,<20,s10,h
else
  set viminfo=!,'100,<20,s10,h
endif

" Disable menu
let g:did_install_default_menus = 1

" Completion setting.
set completeopt=menuone
if exists('+completepopup')
  set completeopt+=popup
  set completepopup=height:4,width:60,highlight:InfoPopup
endif
" Don't complete from other buffer.
set complete=.
" Set popup menu max height.
set pumheight=10
if exists('+pumwidth')
  " Set popup menu max width.
  set pumwidth=10
endif

" Report changes.
set report=0

" Maintain a current line at the time of movement as much as possible.
set nostartofline

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
" set winheight=20
set winheight=1
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways

" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

set ttyfast

" When a line is long, do not omit it in @.
set display=lastline
" Display an invisible letter with hex format.
set display+=uhex

" For conceal.
set conceallevel=2

set colorcolumn=79

if exists('+previewpopup')
  set previewpopup=height:10,width:60
endif

" Disable signcolumn
set signcolumn=no
