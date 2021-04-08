# DIRECTORY
abbr l   "exa --long --header"
abbr la  "exa --long --header --all"
abbr lag "exa --long --header --all --grid"
abbr l1  "exa -1"
abbr lt  "exa --tree"
abbr llt "exa --long --tree"

abbr ..    "cd .."
abbr ...   "cd ../.."
abbr ....  "cd ../../.."
abbr ..... "cd ../../../.."

abbr md   "mkdir -p"
abbr rmr  "rm -r"
abbr rmrf "rm -rfi"

# VIM
abbr vi  nvim
abbr vim nvim

# MISC
abbr cat  bat
abbr catp bat -p
abbr cc   clear
abbr dc   docker-compose
abbr lg   lazygit

# Change config files
abbr cdot     "$EDITOR ~/git/dotfiles"
abbr dotfiles "cd ~/git/dotfiles"
abbr cabbrev  "$EDITOR ~/.config/fish/conf.d/abbrev.fish"
abbr cfish    "$EDITOR ~/.config/fish/config.fish"
abbr cvi      "$EDITOR ~/.config/nvim"
