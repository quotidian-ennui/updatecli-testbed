locals {
  pihole_app_name       = "pihole"
  pihole_image_name     = data.environment_variables.image.items.IMAGE_PIHOLE_NAME
  pihole_version        = data.environment_variables.image.items.IMAGE_PIHOLE_VERSION
  pihole_image_registry = data.environment_variables.image.items.IMAGE_PIHOLE_REGISTRY
  pihole_image          = "${local.pihole_image_registry}/${local.pihole_image_name}:${local.pihole_version}"
}
