" This is the template .vimrc
"
" Some defaults to start off with
" F2 = toggle line numbering
" F3 = toggle showing invisible characters
" F4 = previous color scheme
" F5 = next color scheme

set nocompatible
set rtp+=~/.dotfiles/.vim/bundle/Vundle.vim
call vundle#begin("~/.vundle/")
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ajh17/Spacegray.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'
call vundle#end()
filetype plugin indent on

syntax enable                   " Syntax highlighting
set background=dark             " Terminal with a dark background
set t_Co=256
set expandtab                   " Make a tab to spaces, num of spaces set in tabstop
colorscheme monokai             " Color scheme
set shiftwidth=4                " Number of spaces to use for autoindenting
set tabstop=4                   " A tab is four spaces
set smarttab                    " insert tabs at the start of a line according to
set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set number                      " Enable line numbers
set numberwidth=3               " Line number width
set laststatus=2
set complete=.,w,b,u
set mouse=r

let g:ctrlp_max_files = 0
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_working_path_mode = 'c'
let g:SuperTabDefaultCompletionType = "context"
let g:NERDTreeMouseMode = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

nmap <f1> :NERDTreeToggle<cr>
nmap <f2> :TagbarToggle<cr>
nmap <tab> :tabnext<CR>
nmap <s-tab> :tabprev<CR>

"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"highlight NonText ctermfg=8 guifg=gray
" work around booking shit
" let g:syntastic_puppet_validate_disable = 1
" let g:syntastic_puppet_lint_disable = 1

"source ~/.vim/cyclecolor.vim
