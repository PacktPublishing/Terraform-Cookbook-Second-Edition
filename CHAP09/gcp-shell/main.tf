terraform {
  required_version = "~> 1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "google" {
  region = "us-central1"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "google_compute_network" "vpc_network" {
  name = "tf-demo-shell-${random_string.random.result}"
}