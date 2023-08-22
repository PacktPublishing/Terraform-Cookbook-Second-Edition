terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.18"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg-app" {
  name     = "rg-demooutput-${random_string.random.result}"
  location = "westeurope"
}

resource "azurerm_service_plan" "plan-app" {
  name                = "spdemo-${random_string.random.result}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  os_type  = "Linux"
  sku_name = "S1"
}

resource "azurerm_app_service" "app" {
  name                = "appservice-${random_string.random.result}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  app_service_plan_id = azurerm_service_plan.plan-app.id

  site_config {
  }
}

output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_app_service.app.name
}
