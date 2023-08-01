terraform {
  required_version = "~> 1.5"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    environment = {
      source  = "EppO/environment"
      version = "1.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.0"
    }
  }

}
