platform="$(uname -s)"
case $platform in
  Linux*)
    export GOROOT=/usr/local/go;
    export GOPATH=$HOME;
    ;;
  Darwin*)
    export GOROOT="$(brew --prefix golang)/libexec"
    export GOPATH=$HOME/go
esac

export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
