" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/sab/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/sab/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/sab/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/sab/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/sab/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["base16-vim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/base16-vim"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0" },
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/vim-go"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/sab/.local/share/nvim/site/pack/packer/start/vim-surround"
  }
}

-- Config for: galaxyline.nvim
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15statusline\frequire\0", "config", "galaxyline.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
