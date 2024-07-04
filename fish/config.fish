# Fish settings
fish_vi_key_bindings  # vi-mode

set -Ux EDITOR nvim
set -Ux VISUAL nvim

if status is-interactive
and test (tty) = "/dev/tty1"
  startx ~/.config/X11/xinit/xinitrc
end

if status is-interactive
  source ~/.config/fish/setup.fish
end

# Local config
test -f ~/.local/fish/config.fish; and source ~/.local/fish/config.fish
