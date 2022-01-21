local M = {}

M.keymap = function(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.reload_nvim_config = (function()
  local config_file = vim.fn.stdpath('config')..'/init.lua'
  local cmd = 'source '..config_file
  print('Reloading '..config_file)
  vim.api.nvim_command(cmd)
  print('Done!')
end)

return M
