" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'    " Keybinding helper
Plug 'liuchengxu/vista.vim'        " View and search LSP symbols, tags
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }           " Completion
Plug 'preservim/nerdtree'          " File tree
Plug 'Xuyuanp/nerdtree-git-plugin' " Git plugin for NERDTree
Plug 'ryanoasis/vim-devicons'      " Icons for vim plugins
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'        " Better comments
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vim-utils/vim-man'
Plug 'fatih/vim-go'

" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'phanviet/vim-monokai-pro'
Plug 'joshdick/onedark.vim'

call plug#end()
