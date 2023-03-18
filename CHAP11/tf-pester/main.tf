terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-demo-pester"
  location = "westeurope"
}

resource "azurerm_storage_account" "storage" {
  name                     = "sademotestpester123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only = false
  tags = {
    DEMO = "book"
  }
}