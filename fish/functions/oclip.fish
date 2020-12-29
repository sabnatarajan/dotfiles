function oclip -d "Universal paste from clipboard"
  set -l os (uname -s)
  if test $os = "Darwin"
    pbpaste
  else if $os = "Linux"
    xlip -out
  end
end
