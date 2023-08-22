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

# provider "kubernetes" {
# }

# resource "kubernetes_namespace" "ns" {
#   metadata {
#     labels = {
#       mylabel = "ingress"
#     }
#     name = "ingress"
#   }
# }


resource "helm_release" "nginx_ingress" {
  name             = "ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.5.2"
  namespace        = "ingress" # kubernetes_namespace.ns.metadata.0.name
  create_namespace = true
  wait             = true


  set {
    name  = "controller.replicaCount"
    value = 2
  }

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }
}
