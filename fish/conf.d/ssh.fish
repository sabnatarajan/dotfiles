# Autostart the SSH agent if not started
set -l ssh_agent_pid (pgrep ssh-agent)
if test "x" = "x$ssh_agent_pid"
  eval (ssh-agent -c) > /dev/null
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end
