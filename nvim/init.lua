-- Neovim config
require("settings")
require("plugins")

local utils = require("utils")

require('colorizer').setup()
require('lualine').setup()

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
utils.keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
utils.keymap('n', '<leader>fr', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
utils.keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<CR>')
utils.keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')
utils.keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>')
utils.keymap('n', '<leader>ft', '<cmd>lua require("telescope.builtin").file_browser()<CR>')
utils.keymap('n', '<leader>fG', '<cmd>lua require("telescope.builtin").git_commits()<CR>')

--------
-- LSP 
--------
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.cmd('set shortmess+=c')

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
  buf_set_keymap('n', '<leader>fd', '<cmd>lua require("telescope.builtin").diagnostics()<CR>',               opts)

  local expr = { expr = true }
  utils.keymap('i', '<c-j>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', expr)
  utils.keymap('i', '<c-k>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', expr)
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
utils.keymap('n', '<leader>md', ':Glow<CR>')
