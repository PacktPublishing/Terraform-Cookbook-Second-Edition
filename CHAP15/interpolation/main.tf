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


resource "azurerm_resource_group" "rg-app" {
  name = var.resource_group_name # correct
  #name     = ${var.resource_group_name} # error
  location = "westeurope"
}


variable "resource_group_name" {
  default = "rg-demo-error"
}