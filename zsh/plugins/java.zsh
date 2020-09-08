javaset() {
  local java_version=$1
  if [ -z $1 ]; then
    cat <<EOF 
    Must specify a version:
    Example: javaset 8
EOF
    return
  fi

  whichos > /dev/null
  case $OS_DISTR in
    "Arch Linux")
      sudo archlinux-java set java-$1-openjdk
      ;;
    "Debian")
      # FIXME:
      ;;
    "OSX")
      export JAVA_HOME=$(/usr/libexec/java_home -v $1)
      ;;
  esac
}
