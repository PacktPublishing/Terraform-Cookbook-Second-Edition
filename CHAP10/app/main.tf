terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.0"
    }
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}

resource "kubernetes_namespace" "ns" {
  metadata {
    labels = {
      mylabel = "demobook"
    }

    name = "myapp"
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "webapp"
    namespace = kubernetes_namespace.ns.metadata.0.name
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image = "mikaelkrief/demobook:latest"
          name  = "demobookk8s"
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "webapp"
    namespace = kubernetes_namespace.ns.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.deployment.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 31001
    }

    type = "NodePort"
  }
}