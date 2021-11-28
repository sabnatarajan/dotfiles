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
    use 'nvim-treesitter/nvim-treesitter'

    use 'hrsh7th/nvim-cmp' -- Autocompletion 
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- Telescope (Fuzzy finder, file browser)
    use {
      'nvim-telescope/telescope.nvim', 
      requires = {
        {'nvim-lua/popup.nvim'}, 
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
      }
    }

    use 'tpope/vim-commentary'  -- comment stuff out
    use 'tpope/vim-fugitive'    -- A Git wrapper so awesome, it should be illegal
    use 'tpope/vim-surround'    -- quoting/parenthesizing made simple

    use 'chriskempson/base16-vim'  -- Base16 themes
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'lukas-reineke/indent-blankline.nvim'

    use 'npxbr/glow.nvim'
    use 'junegunn/vim-easy-align'
    use 'junegunn/goyo.vim'

    use 'blankname/vim-fish'     -- Syntax highlighting for Fish

    use 'norcalli/nvim-colorizer.lua'
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
o.termguicolors = true

cmd('syntax enable')
cmd('filetype plugin indent on')
cmd('set clipboard+=unnamedplus')

require('colorizer').setup()
require('lualine').setup()
----------------
-- Keybindings
----------------
g.mapleader = ' '       -- Set the leader key
 
keymap('i', '<C-s>', '<Esc>:w<CR>')   -- Ctrl-S as save
keymap('n', '<C-s>', ':w<CR>')        -- Ctrl-S as save
keymap('n', '<leader>ww', ':w<CR>')   -- Easy save
keymap('n', '<leader>qq', ':q<CR>')   -- Easy quit
keymap('n', '<leader>wq', ':wq<CR>')  -- Easy save+quit
keymap('n', '<leader>qa', ':qa!<CR>') -- Easy quit without save
keymap('n', '<leader>rr', ':so ~/.config/nvim/init.lua<CR>') -- Reload config
keymap('n', '<esc>', ':noh<CR>', { silent=true })      -- Clear highlight after search

-- Fugitive
keymap('n', '<leader>gg', ':topleft Git<CR>')  -- Open Fugitive

-- Better indenting
keymap('n', '<S-Down>', '<C-w>2<')
keymap('n', '<S-Left>', '<C-w>2-')
keymap('n', '<S-Right>', '<C-w>2+')
keymap('n', '<S-Up>', '<C-w>2>')

--------------
-- Telescope 
--------------
require('telescope').setup{
  defaults = {
    path_display = {
      "shorten"
    }
  }
}
require('telescope').load_extension('fzf')
keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
keymap('n', '<leader>fr', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<CR>')
keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')
keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>')
keymap('n', '<leader>ft', '<cmd>lua require("telescope.builtin").file_browser()<CR>')
keymap('n', '<leader>fG', '<cmd>lua require("telescope.builtin").git_commits()<CR>')

--------
-- LSP 
--------
o.completeopt = 'menuone,noinsert,noselect'
cmd('set shortmess+=c')

local lsp = require'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }

  -- Code navigation shortcuts
  -- See `:help vim.lsp.*` for documentation on the below functions
  buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
  buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
  buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
  buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
  buf_set_keymap('n', '<c-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
  buf_set_keymap('n', 'grr',         '<cmd>lua vim.lsp.buf.references()<CR>',                                opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
  buf_set_keymap('n', '<leader>F',  '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 opts)

  local expr = { expr = true }
  keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', expr)
  keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', expr)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls', 'bashls' }
for _, server in ipairs(servers) do
  lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

---------------
-- Treesitter
---------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


----------------------
--  Glow (Markdown)
----------------------
keymap('n', '<leader>md', ':Glow<CR>')
