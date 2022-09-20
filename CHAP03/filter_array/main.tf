
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

locals {
  linux_web_app   = toset([for each in var.web_apps : each.name if each.os == "Linux"])
  windows_web_app = toset([for each in var.web_apps : each.name if each.os == "Windows"])
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  tags = {
    ENV = var.environment
  }
}

resource "azurerm_service_plan" "linux-plan-app" {
  name                = "${var.service_plan_name}-${var.environment}-linux"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_service_plan" "windows-plan-app" {
  name                = "${var.service_plan_name}-${var.environment}-windows"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  os_type             = "Windows"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "app" {
  for_each = local.linux_web_app

  name                = each.value
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name
  service_plan_id     = azurerm_service_plan.linux-plan-app.id

  site_config {}
}

resource "azurerm_windows_web_app" "app" {
  for_each = local.windows_web_app

  name                = each.value
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name
  service_plan_id     = azurerm_service_plan.windows-plan-app.id

  site_config {}
}