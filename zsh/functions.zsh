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

function extract {
  if [ -z "$1" ]; then
    # DISPLAY USAGE IF NO PARAMETERS GIVEN
    echo -en "${bold}${violet}@USAGE:${reset}\n${yellow}extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>${reset}"
    echo
  else
    if [ -f $1 ] ; then
      # NAME=${1%.*}
      # mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ./$1    ;;
        *.tar.gz)    tar xvzf ./$1    ;;
        *.tar.xz)    tar xvJf ./$1    ;;
        *.lzma)      unlzma ./$1      ;;
        *.bz2)       bunzip2 ./$1     ;;
        *.rar)       unrar x -ad ./$1 ;;
        *.gz)        gunzip ./$1      ;;
        *.tar)       tar xvf ./$1     ;;
        *.tbz2)      tar xvjf ./$1    ;;
        *.tgz)       tar xvzf ./$1    ;;
        *.zip)       unzip ./$1       ;;
        *.Z)         uncompress ./$1  ;;
        *.7z)        7z x ./$1        ;;
        *.xz)        unxz ./$1        ;;
        *.exe)       cabextract ./$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

whichos() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_DISTR=$NAME
  elif type lsb_release > /dev/null 2>&1; then
    OS_DISTR=$(lsb_release -si)
  elif [ -f /etc/debian_version ]; then
    OS_DISTR=Debian
  else 
    OS_DISTR="Unknown"
  fi
  echo $OS_DISTR
}
