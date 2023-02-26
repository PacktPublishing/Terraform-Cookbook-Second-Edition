terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
  backend "gcs" {
    bucket = "terraformstatebook"
    prefix = "tfstate"
  }
}

provider "google" {
  region = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-demobookstate"
}

resource "google_compute_instance" "instance" {
  name         = "instance-demobookstate"
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