provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "environment" {}

data "environment_variables" "image" {
  filter = "^IMAGE_"
}
