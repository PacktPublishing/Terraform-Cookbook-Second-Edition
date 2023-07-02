terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20"
    }
  }
}

provider "azurerm" {
  features {}
}

import {
  id = "/subscriptions/8a7aace5-74aa-416f-b8e4-2c292b6304e5/resourcegroups/RG-APP-IMPORT"
  to = azurerm_resource_group.rg-app
}