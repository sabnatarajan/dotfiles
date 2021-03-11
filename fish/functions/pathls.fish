# Defined in /Users/sab/.config/fish/functions/pathls.fish @ line 1
function pathls --description 'List paths in /usr/local/opt/trigger/triggerctl/bin /usr/local/opt/trigger/tcli/bin /usr/local/opt/trigger/trigger-oidc-curl/bin /Users/sab/.okta/bin /usr/local/opt/avro-tools/ /usr/local/opt/ccloud-cli/ /usr/local/opt/google-cloud-sdk/bin/'
  echo $fish_user_paths | tr " " "\n" | nl
end
