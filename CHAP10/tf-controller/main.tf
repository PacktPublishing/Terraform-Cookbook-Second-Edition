terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7.1"
    }
  }
}

provider "helm" {
  kubernetes {
  }
}

resource "helm_release" "tf-controller" {
  name       = "tf-controller"
  repository = "https://weaveworks.github.io/tf-controller/"
  chart      = "tf-controller"
  namespace  = "flux-system"
  wait       = true
}