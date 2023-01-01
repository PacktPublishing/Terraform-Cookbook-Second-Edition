terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.35"
    }

  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}


resource "azurerm_resource_group" "rg-app" {
  name     = "rg-demo-feature"
  location = "westeurope"
}