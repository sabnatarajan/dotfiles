# Fish settings
fish_vi_key_bindings  # vi-mode

set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

if status is-interactive
and test (tty) = "/dev/tty1"
  startx ~/.config/X11/xinit/xinitrc
end

if status is-interactive
  source ~/.config/fish/setup.fish
end

# Autostart tmux
# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
# only run in interactive (not automated SSH for example)
if status is-interactive
# don't nest inside another tmux
and not set -q TMUX
and not test (tty) = "/dev/tty1"
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
  tmux new-session -A -s main
  gpg-connect-agent updatestartuptty /bye > /dev/null;
end

## ASDF Config
# pyenv (asdf still uses pyenv under the hood)
set -gx PYTHON_BUILD_ARIA2_OPTS "-x 10 -k 1M" # Use aria2c when downloading
# asdf
type -f asdf > /dev/null 2>&1; and source $HOME/.asdf/asdf.fish

# Local config
test -f ~/.local/fish/config.fish; and source ~/.local/fish/config.fish
