if [[ "$(uname -s)" == "Linux" ]]; then
  GCLOUD_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/google-cloud-sdk
elif [[ "$(uname -s)" == "Darwin" ]]; then
  GCLOUD_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
fi

if [[ -z $GCLOUD_HOME ]]; then
  echo "No gcloud"
  return
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f $GCLOUD_HOME/path.zsh.inc ]; then . $GCLOUD_HOME/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
if [ -f $GCLOUD_HOME/completion.zsh.inc ]; then . $GCLOUD_HOME/completion.zsh.inc; fi

if command -v gcloud 1>/dev/null 2>&1; then
  export CLOUDSDK_PYTHON="$(which python2)"
fi
