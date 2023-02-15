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

resource "azurerm_resource_group" "rg" {
  name     = "RG-AppRefactobook"
  location = "westeurope"
}

resource "azurerm_service_plan" "plan" {
  name                = "Plan-AppRefactobook"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "S1"
  os_type             = "Linux"
}


# resource "azurerm_linux_web_app" "app1" {
#   name                = "MyAppRefactbook-1"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   service_plan_id     = azurerm_service_plan.plan.id
#   site_config {}
# }

# resource "azurerm_linux_web_app" "app2" {
#   name                = "MyAppRefactbook-2"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   service_plan_id     = azurerm_service_plan.plan.id
#   site_config {}
# }

locals {
  webapp_list = ["MyAppRefactbook-1", "MyAppRefactbook-2"]
}

resource "azurerm_linux_web_app" "apps" {
  for_each            = toset(local.webapp_list)
  name                = each.value
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  site_config {}
}