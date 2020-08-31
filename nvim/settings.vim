syntax enable                   " Syntax highlighting
set hidden                      " Required for multiple buffers
set nowrap                      " Do not wrap long lines
set encoding=utf-8              " Encoding
set pumheight=10                " Make the popup menu smaller
set cmdheight=2                 " More space to display messages
set mouse=a                     " Enable mouse
set noerrorbells                " No bells for errors
set tabstop=2 softtabstop=2     " Tab width
set shiftwidth=2                " Space width for indentation
set expandtab                   " Convert tabs to spaces
set smartindent                 " Smart indentation
set autoindent                  " Auto indentation
set nu                          " Line numbers
set rnu                         " Relative line numbers
set smartcase                   " Case sensitive search if pattern has uppercase
set noshowmode                  " Modes are not shown (-- INSERT --)
set cursorline                  " Enable highlighting of current line
set ruler                       " Show cursor position 
set clipboard+=unnamedplus      " Copy-paste between vim and system
set incsearch                   " Highlight search matches while typing
set splitbelow                  " Horizontal splits default to below
set splitright                  " Vertical splits default to right
set showtabline=2               " Always show tabs
set laststatus=2                " Always display status line
set noswapfile
set nobackup
set nowritebackup
set undofile

if has("nvim")
  set inccommand=split
endif

set background=dark             " Background 
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set updatetime=300              " Faster completion

let g:python_host_prog = '$HOME/.config/pyenv/versions/nvim2/bin/python'
let g:python3_host_prog = '$HOME/.config/pyenv/versions/nvim3/bin/python'
