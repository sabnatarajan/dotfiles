-- Neovim config
require "settings"
require "plugins"
require "completion"
require "lsp"

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

-- luasnip setup
local luasnip = require 'luasnip'


---------------
-- Treesitter
---------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}


----------------------
--  Glow (Markdown)
----------------------
utils.keymap('n', '<leader>md', ':Glow<CR>')
