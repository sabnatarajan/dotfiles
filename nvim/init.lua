-- Neovim config
require "plugins"
require "settings"
require "completion"
require "lsp"

local utils = require("utils")

require('colorizer').setup()
require('lualine').setup{
  options = {
    theme = 'gruvbox',
    section_separators = '',
    component_separators = '',
  }
}

-----------------------------------------------------------------------
-- Telescope 
-----------------------------------------------------------------------
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
utils.keymap('n', '<leader>pp', '<cmd>lua require("telescope.builtin").builtin()<CR>')

-- luasnip setup
local luasnip = require 'luasnip'


-----------------------------------------------------------------------
-- Treesitter
-----------------------------------------------------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = {
    'c', 'lua',
    'rust',
    'bash', 'fish', 'gitignore',
    'go', 'gomod',
    'help', 'comment',
    'hjson', 'json', 'json5', 'jsonc', 'yaml',
    'hocon',
    'dockerfile', 'hcl',
    'java', 'scala',
    'javascript', 'tsx', 'html', 'css',
    'markdown', 'markdown_inline',
    'proto',
    'vim',
  },
  sync_install = false,
  auto_install = true,
  highlight = {enable = true}
}


-----------------------------------------------------------------------
--  Glow (Markdown)
-----------------------------------------------------------------------
utils.keymap('n', '<leader>md', ':Glow<CR>')


-----------------------------------------------------------------------
-- Toggleterm config
-----------------------------------------------------------------------
local toggleterm = require "toggleterm"
local term = require "toggleterm.terminal".Terminal

function term_on_open(term)
  vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'qq', "<cmd>close<CR>", {noremap=true, silent=true})
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<leader>tt]],
  insert_mappings = false,
  hide_numbers = true,
  start_in_insert = true,
  shell = "fish",
  direction = "float",
  float_opts = { 
    border = "curved", 
    winblend = 0, 
    highlights = { border = "Normal", background = "Normal", },
  },
  on_open = term_on_open
})

-- helpful mappings to make moving in and out of a terminal easier once toggled, 
-- whilst still keeping it open.
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-q>', "<cmd>ToggleTerm<CR>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- custom commands
local htop = term:new({ cmd = 'htop', hidden = true, on_open = term_on_open })
function htop_toggle() htop:toggle() end
utils.keymap('n', '<leader>tht', '<cmd>lua htop_toggle()<CR>')

local lazygit = term:new({ cmd = 'lazygit', hidden = true, on_open = term_on_open })
function lazygit_toggle() lazygit:toggle() end
utils.keymap('n', '<leader>tlg', '<cmd>lua lazygit_toggle()<CR>')

local python = term:new({ cmd = 'python3', hidden = true, on_open = term_on_open })
function python_toggle() python:toggle() end
utils.keymap('n', '<leader>tpy', '<cmd>lua python_toggle()<CR>')

