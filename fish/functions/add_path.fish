function add_path -d "Add a directory to the path if it doesn't exist"
  if test (count $argv) = 0
    echo "Must supply a path"
  else
    contains $argv[1] $fish_user_paths; or set -Ua fish_user_paths $argv[1];
  end
end
