terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "sturdy-tome-376118"
  region  = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-demobook"
}

resource "google_compute_instance" "instance" {
  name         = "instance-demobook"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
  }
}
