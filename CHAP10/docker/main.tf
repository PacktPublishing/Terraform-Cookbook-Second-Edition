
terraform {
  required_version = "~> 1.1"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}

provider "docker" {
}


resource "docker_image" "image" {
  name = "mikaelkrief/demobook:latest"
}

resource "docker_container" "container" {
  name  = "demo"
  image = docker_image.image.image_id
}