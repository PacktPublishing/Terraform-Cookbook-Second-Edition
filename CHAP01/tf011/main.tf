terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20"
    }
  }
}

provider "azurerm" {}

variable "resource_group_name" {
  default = "rg_test"
  type    = string
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westeurope"
}

resource "azurerm_public_ip" "pip" {
  name                = "book-ip"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "bookdevops"
}