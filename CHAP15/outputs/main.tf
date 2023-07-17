terraform {
  required_version = "~> 1.3"
  required_providers {
    azurerm = {
      version = "~> 3.23"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  webapplist = ["webappdemobook1", "webappdemobook2"]
}

resource "random_string" "str" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${random_string.str.result}"
  location = var.location
}

resource "azurerm_service_plan" "plan-app" {
  name                = "${var.service_plan_name}-${random_string.str.result}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app" {
  for_each            = toset(local.webapplist)
  name                = "${each.value}-${random_string.str.result}"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name
  service_plan_id     = azurerm_service_plan.plan-app.id
  site_config {}
}

output "webapps_urls" {
  value = azurerm_linux_web_app.app.default_hostname
  #value = [for app in azurerm_linux_web_app.app : app.name]
}

