terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.16"
    }
  }
}

provider "kind" {}

locals {
  k8s_config_path = pathexpand("~/.kube/config")
}

resource "kind_cluster" "default" {
  name            = "cluster-book"
  wait_for_ready  = true
  kubeconfig_path = local.k8s_config_path
}