set -Ux PYENV_ROOT $HOME/.pyenv
pyenv init - | source
status --is-interactive; and source (pyenv virtualenv-init -|psub)
