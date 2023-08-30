set positional-arguments

# show recipes
help:
  just --list

# run updatecli diff
diff *args:
  updatecli diff --values ./terraform/image-spec.yml $@

# run updatecli apply
apply *args:
  updatecli apply --values ./terraform/image-spec.yml $@

# run terraform format
format:
  cd terraform && terraform fmt
