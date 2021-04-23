-- Neovim config

local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local o, b, w = vim.o, vim.bo, vim.wo

local function keymap(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

if require('autoload')() then
  return
end

------------
-- Plugins
------------

require('packer').startup {
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'         -- Common configs for LSP client
    use 'nvim-lua/lsp_extensions.nvim'  -- Extensions for built-in LSP
    use 'nvim-lua/completion-nvim'      -- Autocomplete

    use 'nvim-treesitter/nvim-treesitter'
    
    -- Telescope (Fuzzy finder, file browser)
    use {
      'nvim-telescope/telescope.nvim', 
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use 'tpope/vim-commentary'  -- comment stuff out
    use 'tpope/vim-fugitive'    -- A Git wrapper so awesome, it should be illegal
    use 'tpope/vim-surround'    -- quoting/parenthesizing made simple

    use 'chriskempson/base16-vim'  -- Base16 themes
    use {  -- Lightweight statusline
      'glepnir/galaxyline.nvim', branch=main,
      config = function() require'statusline' end,
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'npxbr/glow.nvim'
    use 'junegunn/vim-easy-align'

    use 'blankname/vim-fish'     -- Syntax highlighting for Fish
  end
}

-- Set the base16 theme
if fn.filereadable(fn.expand("~/.vimrc_background")) then
  cmd('let base16colorspace=256')
  cmd('source ~/.vimrc_background')
end

-------------
-- Settings
-------------

o.encoding = 'utf-8'
o.hidden = true        -- Multiple (hidden) buffers
o.mouse = 'a'          -- Enable mouse on all modes
o.pumheight = 10       -- Smaller popup menu
o.cmdheight = 2        -- More space to display messages
o.errorbells = false
o.smartcase = true     -- Case sensitive search if pattern has uppercase
o.showmode = false     -- Modes are not shown (-- INSERT --)
o.ruler = true         -- Show cursor position
o.scrolloff = 10       -- Start scrolling before reaching the end
o.background = 'dark'
o.incsearch = true     -- Highlight search matches while typing
o.inccommand = 'split' -- Show partial results in a preview window
o.laststatus = 2       -- Always display the status line
o.showtabline = 2      -- Always show the tab-page labels
o.updatetime = 200     -- Delay before swapfile is saved

w.number = true        -- Line numbers
w.rnu = false          -- Relative line numbers
w.wrap = false         -- Don't wrap long lines
w.cursorline = true    -- Highlight the current line

b.expandtab = true     -- Convert tabs to spaces
b.tabstop = 2          -- 
b.softtabstop = 2      --
b.autoindent = true    --
b.smartindent = true   --
b.shiftwidth = 2       --
b.swapfile = false
o.backup = false
o.writebackup = false
o.switchbuf = 'usetab,newtab'
g.switchbuf = 'usetab,newtab'
o.splitright = true
o.splitbelow = true
o.shell="/bin/bash"
g.clipboard = "unnamedplus"
o.clipboard = "unnamedplus"

cmd('syntax enable')
cmd('filetype plugin indent on')

----------------
-- Keybindings
----------------
g.mapleader = ' '       -- Set the leader key
 
keymap('i', '<C-s>', '<Esc>:w<cr>')   -- Ctrl-S as save
keymap('n', '<C-s>', ':w<cr>')        -- Ctrl-S as save
keymap('n', '<leader>ww', ':w<cr>')    -- Easy save
keymap('n', '<leader>qq', ':q<cr>')    -- Easy quit
keymap('n', '<leader>wq', ':wq<cr>')  -- Easy save+quit
keymap('n', '<leader>qa', ':qa!<cr>') -- Easy quit without save
keymap('n', '<leader>rr', '<cmd>luafile ~/.config/nvim/init.lua<cr>') -- Easy quit without save

-- Better indenting
keymap('n', '<S-Down>', '<C-w>2<')
keymap('n', '<S-Left>', '<C-w>2-')
keymap('n', '<S-Right>', '<C-w>2+')
keymap('n', '<S-Up>', '<C-w>2>')

--------------
-- Telescope 
--------------
keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
keymap('n', '<leader>ft', '<cmd>lua require("telescope.builtin").file_browser()<cr>')

--------
-- LSP 
--------
o.completeopt = 'menuone,noinsert,noselect'
cmd('set shortmess+=c')

local lsp = require'lspconfig'
local on_attach = function(client)
    require'completion'.on_attach(client)
end

lsp.rust_analyzer.setup({ on_attach=on_attach })
lsp.pyright.setup({ on_attach=on_attach })
lsp.gopls.setup({ on_attach=on_attach })

local silent = { silent = true }
local expr = { expr = true }
keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', expr)
keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', expr)

-- Code navigation shortcuts
keymap('n', '<leader><c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', silent)
keymap('n', '<leader>K',     '<cmd>lua vim.lsp.buf.hover()<CR>', silent)
keymap('n', '<leader>gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>', silent)
keymap('n', '<leader><c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silent)
keymap('n', '<leader>1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', silent)
keymap('n', '<leader>gr',    '<cmd>lua vim.lsp.buf.references()<CR>', silent)
keymap('n', '<leader>g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', silent)
keymap('n', '<leader>gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', silent)
keymap('n', '<leader>gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', silent)


---------------
-- Treesitter
---------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


----------------------
--  Glow (Markdown)
----------------------
keymap('n', '<leader>md', ':Glow<cr>')
