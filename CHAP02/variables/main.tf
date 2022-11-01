terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      version = ">= 2.10.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  description = "The name of the resource group"
}

variable "location" {
  description = "The name of the Azure location"
  default     = "westeurope"
  validation {
    condition     = contains(["westeurope", "westus"], var.location)
    error_message = "The location must be westeurope or westus."
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}