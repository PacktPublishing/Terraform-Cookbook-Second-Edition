terraform {
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


resource "google_compute_instance" "instance" {
  name         = "inst-demo-${random_string.random.result}"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"
  }
}
