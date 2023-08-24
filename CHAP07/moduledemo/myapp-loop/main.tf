terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.23"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "random_string" "randomstr" {
  length  = 5
  special = false
  upper   = false
}


locals {
  webapp_list = ["webapp12412", "webapp22412"]
}

resource "azurerm_resource_group" "rg-app" {
  name     = "rg_app_demo_loop_${random_string.randomstr.result}"
  location = "West Europe"
}

module "webapp" {
  source              = "../Modules/webapp"
  for_each            = toset(local.webapp_list)
  app_name            = "${each.key}-${random_string.randomstr.result}"
  service_plan_name   = "spmyapp-${each.key}-${random_string.randomstr.result}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
}

output "app_service_urls" {
  value = values(module.webapp)[*].webapp_url
}