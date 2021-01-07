# Fish settings
fish_vi_key_bindings  # vi-mode

set -U EDITOR nvim
set -U VISUAL nvim

starship init fish | source

# Autostart tmux
# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
# only run in interactive (not automated SSH for example)
if status is-interactive
# don't nest inside another tmux
and not set -q TMUX
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
end

# Local config
if test -f ~/.local/fish/config.fish
  . ~/.local/fish/config.fish
end