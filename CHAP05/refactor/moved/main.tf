terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.23"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-AppRefactobook2"
  location = "westeurope"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "snet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# locals {
#   subnet_list = {
#     subnet1 = "10.0.1.0/24"
#     subnet2 = "10.0.2.0/24"
#   }
# }


# resource "azurerm_subnet" "snetlist" {
#   for_each             = local.subnet_list
#   name                 = each.key
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [each.value]
# }

# moved {
#   from = azurerm_subnet.snet1
#   to   = azurerm_subnet.snetlist["subnet1"]
# }

# moved {
#   from = azurerm_subnet.snet2
#   to   = azurerm_subnet.snetlist["subnet2"]
# }