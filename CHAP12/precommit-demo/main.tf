terraform {
  required_version = "~> 1.1"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}

resource "random_string" "random" {
  length  = var.random_length
  special = false
  upper   = false
}

variable "random_length" {
  default = 4
}