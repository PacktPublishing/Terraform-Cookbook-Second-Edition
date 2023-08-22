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

variable "rg_name" {
  description = "Name of the resource group"
  default     = "RG-DEMO-APP"
  type        = string
}

variable "location" {
  description = "location"
  default     = "westeurope"
  type        = string
}

resource "azurerm_resource_group" "rg-app" {
  name     = var.rg_name
  location = var.location
  tags = {
    ENV = var.environment
  }
}

variable "environment" {
  default = "DEMO"
  type    = string
}