
terraform {
  required_providers {
    kustomization = {
      source = "kbst/kustomization"
      version = "0.9.2"
    }
  }
}

provider "kustomization" {
  kubeconfig_path = pathexpand("~/.kube/config")
}

variable "environment" {
  type = string
  description = "Environment name"
  default = "dev"
}

data "kustomization" "current" {
  # using the workspace name to select the correct overlay
  path = "manifests/overlays/${var.environment}"
}

resource "kustomization_resource" "current" {
  # use the new for_each to handle each resource individually
  for_each = data.kustomization.current.ids
  manifest = data.kustomization.current.manifests[each.value]
}