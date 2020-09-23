#!/usr/bin/env zsh


# -------------------
# Profiling
# -------------------
ZSH_PROFILING_ENABLE=false
if [[ "$ZSH_PROFILING_ENABLE" == true ]]; then
    zmodload zsh/zprof
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/startlog.$$
    setopt xtrace prompt_subst
fi

# -------------------
# Instant Prompt
# -------------------
# Enable instant prompt for powerlevel10k. This should stay at the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------
# ZSH config
# -------------------
export DOTFILES_HOME=$HOME/dotfiles
export ZSH_HOME="$DOTFILES_HOME/zsh"

# Init ZSH completion
# -------------------
autoload -Uz compinit promptinit 
autoload -U +X bashcompinit

# Load And Initialize The Completion System Ignoring Insecure Directories With A
# Cache Time Of 20 Hours, So It Should Almost Always Regenerate The First Time A
# Shell Is Opened Each Day.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files
promptinit
setopt prompt_subst

# Main ZSH settings
# -----------------
source $ZSH_HOME/settings.zsh


# -------------------
# Zinit
# -------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source $ZINIT_HOME/zinit.zsh
autoload -Uz _zinit
compinit
bashcompinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-completions
# zinit light zdharma/fast-syntax-highlighting

# -------------------
# THEME
# -------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
PS1="Ready >"
zinit ice wait'!' lucid
zinit ice depth=1; zinit light romkatv/powerlevel10k

# sharkdp/fd: Fast alternative to find
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# -------------------
# My ZSH stuff
# TODO: reorganize this
# -------------------

foreach conf (
  env
  aliases
  functions
  plugins/gcloud 
  plugins/pyenv
  plugins/go
  plugins/z
  plugins/fzf
  plugins/java
) {
  source $ZSH_HOME/$conf.zsh
}

# Local Override
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local

# Load theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

