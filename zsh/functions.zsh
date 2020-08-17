zd() {
  local dir
  dir=$(fd --type directory | fzf +m) || return
  cd $dir || return
}

zda() {
  local dir
  dir=$(fd --type directory --hidden | fzf +m) || return
  cd $dir || return
}

zroot() {
  local gitrootdir
  gitrootdir=$(git rev-parse --show-toplevel) || return
  cd $gitrootdir || return
}


