function pathrm -d "Remove a path from fish_user_paths"
  if test (count $argv) = 0
    echo "Usage: pathrm <index> (Use pathls to get index)" 
  else
    set -l p $fish_user_paths[$argv[1]]
    read -l -P "Delete $p? [y/N]: " confirm
    switch $confirm
      case Y y
        set --erase --universal fish_user_paths[$argv[1]]
    end
  end
end
