function pathrm -d "Remove a path from fish_user_paths"
  if test (count $argv) = 0
    echo "Usage: pathrm <index> (Use pathls to get index)" 
  else
    set --erase --universal fish_user_paths[$argv[1]]
  end
end
