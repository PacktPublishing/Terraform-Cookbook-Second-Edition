terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.9.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "8a7aace5-74aa-416f-b8e4-2c292b6304e5"
  alias           = "sub1"
  features {}
}

provider "azurerm" {
  subscription_id = "249e22ad-c375-4f9b-a370-2242f83515d4"
  alias           = "sub2"
  features {}
}

resource "azurerm_resource_group" "rg" {
  provider = azurerm.sub1
  name     = "rg-sub1"
  location = "West Europe"
}

resource "azurerm_resource_group" "rg2" {
  provider = azurerm.sub2
  name     = "rg-sub2"
  location = "West Europe"
}