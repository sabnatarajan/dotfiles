export PYENV_ROOT="$HOME/.config/pyenv"
export PATH="$PATH:$PYENV_ROOT/bin"

if command -v pyenv 1>/dev/null 2>&1; then 
  eval "$(pyenv init -)" 
fi

# if command -v pyenv virtualenv 1>/dev/null 2>&1; then
#   eval "$(pyenv virtualenv-init -)"
# fi
