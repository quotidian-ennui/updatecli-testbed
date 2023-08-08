# show recipes
help:
  just --list

# run updatecli diff
diff:
  updatecli diff --values ./terraform/image-spec.yml

# run updatecli apply
apply:
  updatecli apply --values ./terraform/image-spec.yml

# run terraform format
format:
  cd terraform && terraform fmt
