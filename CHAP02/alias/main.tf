terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.9.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  alias           = "sub1"
  features {}
}

provider "azurerm" {
  subscription_id = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy"
  alias           = "sub2"
  features {}
}

resource "azurerm_resource_group" "rg" {
  provider = azurerm.sub1
  name     = "rg-sub1"
  location = "westeurope"
}

resource "azurerm_resource_group" "rg2" {
  provider = azurerm.sub2
  name     = "rg-sub2"
  location = "westeurope"
}