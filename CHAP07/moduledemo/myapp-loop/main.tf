
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

locals {
  webapp_list = ["webapp12412", "webapp22412"]
}

resource "azurerm_resource_group" "rg-app" {
  name     = "rg_app_demo_loop"
  location = "West Europe"
}

module "webapp" {
  source              = "../Modules/webapp"
  for_each            = toset(local.webapp_list)
  app_name            = each.key
  service_plan_name   = "spmyapp-${each.key}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
}

output "app_service_urls" {
  value = values(module.webapp)[*].webapp_url
}