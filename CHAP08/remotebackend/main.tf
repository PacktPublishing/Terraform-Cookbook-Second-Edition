terraform {
  required_version = "~> 1.1"
  backend "azurerm" {
    resource_group_name  = "RG-TFBACKEND"
    storage_account_name = "storagetfbackend"
    container_name       = "tfstate"
    key                  = "myapp.tfstate"
  }
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
  name     = "RG-demo"
  location = "westeurope"
}