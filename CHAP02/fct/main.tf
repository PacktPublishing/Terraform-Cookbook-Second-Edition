terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.18"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "app_name" {
  description = "Name of application"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}


#resource "azurerm_resource_group" "rg-app" {
#  name     = upper(format("RG-%s-%s",var.app_name,var.environment))
#  location = "westeurope"
#}

#FOR CONDITION
resource "azurerm_resource_group" "rg-app" {
  name     = var.environment == "Production" ? upper(format("RG-%s", var.app_name)) : upper(format("RG-%s-%s", var.app_name, var.environment))
  location = "westeurope"
}
