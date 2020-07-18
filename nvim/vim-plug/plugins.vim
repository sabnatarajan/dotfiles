call plug#begin('~/.vim/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim'          " Completion
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'       " Better comments
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'   " Keybinding helper


" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'phanviet/vim-monokai-pro'

call plug#end()
