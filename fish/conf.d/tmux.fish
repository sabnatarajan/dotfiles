set -l num_plugins_installed (ls $HOME/.config/tmux/plugins/ | awk '{print $3}' | uniq -c)
if test "$num_plugins_installed" -lt 2
  set_color yellow;
  echo "Have you installed the tmux plugins yet? (prefix + I)" 1>&2
  set_color normal;
end
