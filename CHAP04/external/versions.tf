terraform {
  required_version = "~> 1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.24"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2"
    }
  }
}