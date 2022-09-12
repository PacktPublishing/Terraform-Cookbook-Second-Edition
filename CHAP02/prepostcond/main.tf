terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rgdep"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       =  [var.address_space]
  lifecycle {
    precondition {
      condition = cidrnetmask(var.address_space) == "255.255.0.0"
      error_message = "The IP Range must be /16"
    }
    postcondition {
      condition = self.location  == "westeurope"
      error_message = "Location must be West Europe"
    }
  }
}


variable "address_space" {
  default = "10.0.0.0/24"
}