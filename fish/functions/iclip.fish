function iclip -d "Universal copy to clipboard"
  set -l os (uname -s)
  if test $os = "Darwin"
    pbcopy $argv
  else if $os = "Linux"
    xclip -in -selection -clipboard
  end
end
