export DOTFILES_HOME=$HOME/dotfiles
export ZSH_HOME="$DOTFILES_HOME/zsh"

source $ZSH_HOME/zinit/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting


. $ZSH_HOME/env.zsh
. $ZSH_HOME/settings.zsh
. $ZSH_HOME/aliases.zsh

# PLUGINS
PLUGINS=(
  gcloud 
  pyenv
  go
)

for plug in "${PLUGINS[@]}"; do
  source "$ZSH_HOME/plugins/$plug.zsh"
done

# THEME
. $ZSH_HOME/themes/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# LOCAL OVERRIDE
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

autoload -Uz compinit
