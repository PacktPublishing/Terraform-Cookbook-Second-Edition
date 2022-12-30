terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.35"
    }

  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg-app" {
  name     = "rg-demo-feature"
  location = "westeurope"
}

resource "azurerm_storage_account" "sa" {
  name                     = "satestfeature11"
  resource_group_name      = azurerm_resource_group.rg-app.name
  location                 = "westeurope"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
}
