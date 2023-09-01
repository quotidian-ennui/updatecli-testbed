set positional-arguments

# show recipes
help:
  just --list

# run updatecli diff passing in some values
diff *args:
  updatecli diff --values ./terraform/image-spec.yml --values ./version_pinning.yml $@

# run updatecli apply passing in some values
apply *args:
  updatecli apply --values ./terraform/image-spec.yml --values ./version_pinning.yml $@

# run terraform format
format:
  cd terraform && terraform fmt
