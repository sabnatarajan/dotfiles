set -Ux GCLOUD_HOME /usr/local/opt/google-cloud-sdk
if test ! -d $GCLOUD_HOME
    echo ERROR: google-cloud-sdk is not installed!
    echo Install it using
    echo "curl https://sdk.cloud.google.com | bash -s -- --install-dir=/usr/local/opt --disable-prompts"
    exit 0
end
source $GCLOUD_HOME/path.fish.inc