" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
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
Plug 'joshdick/onedark.vim'

call plug#end()
