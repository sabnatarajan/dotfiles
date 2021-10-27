set -l GCLOUD_HOME $HOME/.local/share/google-cloud-sdk
if test -d $GCLOUD_HOME
    . $GCLOUD_HOME/path.fish.inc
end
