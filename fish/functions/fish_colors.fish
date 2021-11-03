function fish_colors -d "Print all fish colors"
  # Thanks to Darkshadow2, adapted from
  # https://github.com/fish-shell/fish-shell/issues/3443#issuecomment-253838672

  set -l bclr (set_color normal)
  set -l bold (set_color --bold)
  printf "\n| %-38s | %-38s |\n" Variable Definition
  echo '|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|'
  for color_name in (string match "fish_color*" (set -n))

    set -l def $$color_name
    set -l clr (set_color $def )
    or begin
        printf "| %-38s | %s%-38s$bclr |\n" "$color_name" (set_color --bold white --background=red) "$def"
        continue
    end
    printf "| $clr%-38s$bclr | $bold%-38s$bclr |\n" "$color_name" "$def"
  end
  echo '|________________________________________|________________________________________|'\n
end
