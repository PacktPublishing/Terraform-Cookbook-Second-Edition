terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.18"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rgdep"
  location = "westus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.address_space]
  lifecycle {
    precondition {
      condition     = cidrnetmask(var.address_space) == "255.255.0.0"
      error_message = "The IP Range must be /16"
    }
    postcondition {
      condition     = self.location == "westeurope"
      error_message = "Location must be westeurope"
    }
  }
}

variable "address_space" {
  default = "10.0.0.0/16"
}
