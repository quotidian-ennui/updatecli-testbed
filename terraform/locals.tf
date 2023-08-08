locals {
  images = yamldecode(file("${path.module}/image-spec.yml"))
}
