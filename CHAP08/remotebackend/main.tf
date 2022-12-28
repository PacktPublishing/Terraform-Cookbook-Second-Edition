provider "azurerm" {
  features {}
}

terraform {
  required_version = ">= 1.0"
  backend "azurerm" {
    resource_group_name  = "RG-TFBACKEND"
    storage_account_name = "storagetfbackend"
    container_name       = "tfstate"
    key                  = "myapp.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-demo"
  location = "westeurope"
}