terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.20"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  network = yamldecode(file("network.yaml"))
}

resource "azurerm_resource_group" "rg" {
  name     = "rgyamldemo"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.network.vnet
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [local.network.address_space]
  dynamic "subnet" {
    for_each = local.network.subnets
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.iprange
    }
  }
}