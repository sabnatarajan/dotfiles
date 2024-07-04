if command -v starship 2>&1 1>/dev/null
	set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml
	starship init fish | source
end
