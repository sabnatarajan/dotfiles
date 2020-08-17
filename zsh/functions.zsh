zd() {
  local dir
  PATTERN=${1:-""}
  dir=$(fd --type directory | fzf +m -q $PATTERN) || return
  cd $dir || return
}

zda() {
  local dir
  PATTERN=${1:-""}
  dir=$(fd --type directory --hidden $PATTERN | fzf +m) || return
  cd $dir || return
}

zroot() {
  local gitrootdir
  gitrootdir=$(git rev-parse --show-toplevel) || return
  cd $gitrootdir || return
}

zz() {
  cd
}
