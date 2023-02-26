terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  region = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-demobook-shell"
}