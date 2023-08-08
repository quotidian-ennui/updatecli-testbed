diff:
  updatecli diff --values ./terraform/image-spec.yml

apply:
  updatecli apply --values ./terraform/image-spec.yml

format:
  cd terraform && terraform fmt
