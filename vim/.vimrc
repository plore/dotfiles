" take care of unicode chars below
set encoding=utf-8
scriptencoding utf-8

" override system default of 'set compatible' on some systems
" vi compatibility is not desired
set nocompatible

"""""""""
" plugins
"""""""""
filetype off    " temporarily turn of filetype distinction
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'					" Plugin manager
Plugin 'hynek/vim-python-pep8-indent'		" PEP8 rules for python
Plugin 'bling/vim-airline'					" useful status bar
Plugin 'vim-airline/vim-airline-themes'		" airline configuration
Plugin 'altercation/vim-colors-solarized'	" nice color scheme
Plugin 'leafgarland/typescript-vim'			" typescript syntax support
Plugin 'octol/vim-cpp-enhanced-highlight'	" better highlighting for modern C++
Plugin 'bronson/vim-trailing-whitespace'	" I dislike trailing whitespace
Plugin 'christoomey/vim-tmux-navigator'		" integrate with tmux pane navigation
Plugin 'scrooloose/nerdtree'				" sidebar explorer
Plugin 'junegunn/goyo.vim'					" distraction-free writing
Plugin 'mikewest/vimroom'					" distraction-free writing
call vundle#end()
filetype plugin indent on " reenable filetype-specific plugins and indentation

"""""""""""""""""""""""
" general configuration
"""""""""""""""""""""""

" whitespace
""""""""""""
set tabstop=4       	" actual tab width in spaces
set shiftwidth=4    	" indent by entire tab lengths using shift commands in normal mode
set softtabstop=4   	" indent by entire tab lengths in insert mode
set noexpandtab     	" do not expand tabs to spaces
set listchars=tab:▸␣	" visualization of tabs
"set list				" make whitespace chars visible

" search & replace
""""""""""""""""""
set incsearch									" move cursor to match while typing
set hlsearch									" highlight all matches for search term (after pressing enter)
nnoremap <silent> <Space> :nohlsearch<Return>	" disable search highting by pressing Space
set ignorecase									" ignore case
set smartcase									" but not if uppercase letter was typed

" misc.
"""""""
syntax enable			" syntax highlighting; allow custom highlighting
set autoindent      	" keep indentation level of last line
set smartindent			" smart indentation for C-like languages
set number          	" line numbers
set textwidth=0			" system config for might have set this to 78 for vim-files
"set formatoptions+=t
"set completeopt=menu"menu,preview
set showcmd
set cursorline			" highlight current line
set showmatch			" highlight matching parentheses etc.
set scrolloff=3			" trigger scrolling when cursors comes this close to screen top or bottom
set nomodeline			" do not interpret line starting with 'vim:' als modelines
autocmd CompleteDone * pclose   " close scratch window automatically

"command line completion
""""""""""""""""""""""""
set wildmenu			        " menu to cycle through matches
set wildmode=list:longest,full  " list all matches and complete longest string, then cycle through completion

" numbers
"""""""""
set nrformats="alpha,bin,hex"	" consider letters, binary and hexadecimal tokens to be numbers
nnoremap + <C-A>
nnoremap - <C-X>

" navigation
""""""""""""
" sane window navigation
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

"folding
""""""""
" these settings are far from optimal
" it would be nice to have shorter folds opened by default
" currently disabled since folds/views sometimes lead to strange behavior (e.g. broken syntax detection)
"set foldmethod=indent	" force myself to indent properly in any language
"set foldnestmax=1		" force myself to keep fold contents small so that only one level is needed
"set foldclose=all		" auto close fold when moving out of it
"nnoremap zC zM			" close all folds rather than just the one (since foldnestmax=1) level under cursor
"nnoremap zO zR			" open all folds
"au BufWinLeave *.* mkview				" save folds; avoid error on opening [No File] by requiring dot in filename
"au BufWinEnter *.* silent loadview		" restore folds on opening

""""""""""""""""""""""""""""""
"plugin-oriented configuration
""""""""""""""""""""""""""""""

"vim-airline
""""""""""""
set laststatus=2						" persistent status line
if &t_Co == 256
	let g:airline_theme="solarized"
elseif &t_Co == 16
	let g:airline_theme="base16_solarized"
else
	let g:airline_theme="term_light"	" passable default with few colors
endif
let g:airline_powerline_fonts = 1		" use special glyphs
let g:airline_exlude_preview = 1		" do not affect preview window

""vim-colors-solarized
""""""""""""""""""""""
if &t_Co <= 16
	colorscheme desert				" much nicer on 8 or 16 color terminals
else
	let g:solarized_termcolors=16	" use terminal emulator's colorscheme
	set background=dark
	colorscheme solarized
	"let g:solarized_contrast="high"
endif

"nerdtree
"""""""""
nnoremap <C-e> :NERDTreeToggle<CR>	" e as in explorer(?)
let NERDTreeShowHidden = 1			" show hidden files by default

