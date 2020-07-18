export DOTFILES_HOME=$HOME/dotfiles
export ZSH_HOME="$DOTFILES_HOME/zsh"

source $ZSH_HOME/zinit/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting


. $ZSH_HOME/env.zsh
. $ZSH_HOME/themes/powerlevel10k/powerlevel10k.zsh-theme
. $ZSH_HOME/settings.zsh
. $ZSH_HOME/aliases.zsh

# PROGRAMS
. $ZSH_HOME/gcloud.zsh
. $ZSH_HOME/pyenv.zsh
. $ZSH_HOME/go.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

. ~/.zshrc_local

autoload -Uz compinit
