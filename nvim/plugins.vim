" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
" Plug 'jremmen/vim-ripgrep'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'    " Keybinding helper
Plug 'liuchengxu/vista.vim'        " View and search LSP symbols, tags
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }           " Completion
" Plug 'preservim/nerdtree'          " File tree
" Plug 'Xuyuanp/nerdtree-git-plugin' " Git plugin for NERDTree
Plug 'ryanoasis/vim-devicons'      " Icons for vim plugins
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'        " Better comments
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'      " highlight words when using f/t motions
Plug 'vim-utils/vim-man'
Plug 'fatih/vim-go'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'

" Themes
Plug 'chriskempson/base16-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'phanviet/vim-monokai-pro'
Plug 'joshdick/onedark.vim'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

lua << EOF
local nvim_lsp = require'lspconfig'

local on_attach = function(client)
    require'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
EOF
