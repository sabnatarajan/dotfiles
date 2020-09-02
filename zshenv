local dotdir="$HOME/.config/zsh"

if [[ -f "$dotdir/.zshrc" ]]; then
    ZDOTDIR="$dotdir"
else
    echo 'no zshrc' > "$HOME/nozshrc"
fi
