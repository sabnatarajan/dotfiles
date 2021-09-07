if not functions --query __direnv_export_eval; and command --search --query direnv
  direnv hook fish | source
end
