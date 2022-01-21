local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local o, b, w = vim.o, vim.bo, vim.wo

-- Set the base16 theme
if fn.filereadable(fn.expand("~/.vimrc_background")) then
  cmd('let base16colorspace=256')
  cmd('source ~/.vimrc_background')
end

-------------
-- Settings
-------------

o.encoding = 'utf-8'
o.hidden = true        -- multiple (hidden) buffers
o.mouse = 'a'          -- enable mouse on all modes
o.pumheight = 10       -- smaller popup menu
o.cmdheight = 2        -- more space to display messages
o.errorbells = false   -- disable error bells/screen flash for errors
o.smartcase = true     -- case sensitive search if pattern has uppercase
o.showmode = false     -- modes are not shown (-- INSERT --)
o.ruler = true         -- show cursor position
o.scrolloff = 10       -- start scrolling before reaching the end
o.background = 'dark'
o.incsearch = true     -- highlight search matches while typing
o.inccommand = 'split' -- show partial results in a preview window
o.laststatus = 2       -- always display the status line
o.showtabline = 2      -- always show the tab-page labels
o.updatetime = 200     -- delay before swapfile is saved

w.number = true        -- line numbers
w.rnu = false          -- relative line numbers
w.wrap = false         -- don't wrap long lines
w.cursorline = true    -- highlight the current line

b.expandtab = true     -- convert tabs to spaces
b.softtabstop = 2      -- number of spaces that <Tab> counts for while editing
b.shiftwidth = 2       -- number of spaces for (auto)indents
b.autoindent = true    --
b.smartindent = true   --
b.swapfile = false
o.backup = false
o.writebackup = false
g.switchbuf = 'usetab,newtab'
o.splitright = true
o.splitbelow = true
o.shell="/bin/bash"
o.termguicolors = true

cmd('syntax enable')               -- enable syntax highlighting
cmd('filetype plugin indent on')  
cmd('set clipboard+=unnamedplus')

----------------
-- Keybindings
----------------
vim.g.mapleader = ' '       -- Set the leader key
 
utils.keymap('i', '<C-s>', '<Esc>:w<CR>')       -- Ctrl-S as save
utils.keymap('n', '<C-s>', '<cmd>w<CR>')        -- Ctrl-S as save
utils.keymap('n', '<leader>ww', '<cmd>w<CR>')   -- Easy save
utils.keymap('n', '<leader>qq', '<cmd>q<CR>')   -- Easy quit
utils.keymap('n', '<leader>wq', '<cmd>wq<CR>')  -- Easy save+quit
utils.keymap('n', '<leader>qa', '<cmd>qa!<CR>') -- Easy quit without save
utils.keymap('n', '<leader>rr', '<cmd>lua require("utils").reload_nvim_config()<CR>') -- Reload config
utils.keymap('n', '<esc>', '<cmd>noh<CR>', { silent=true })      -- Clear highlight after search

-- Fugitive
utils.keymap('n', '<leader>gg', ':topleft Git<CR>')  -- Open Fugitive

-- Better indenting
utils.keymap('n', '<S-Down>', '<C-w>2<')
utils.keymap('n', '<S-Left>', '<C-w>2-')
utils.keymap('n', '<S-Right>', '<C-w>2+')
utils.keymap('n', '<S-Up>', '<C-w>2>')

