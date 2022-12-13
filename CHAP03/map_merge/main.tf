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

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  ## OLD CODE WIThOUT MAP
  #tags = {
  #  ENV = var.environment
  #  CREATEDBY = var.created_by
  #}

  tags = var.tags
}

resource "azurerm_service_plan" "plan-app" {
  name                = "${var.service_plan_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  os_type  = "Windows"
  sku_name = "S1"
}

locals {
  default_app_settings = {
    "DEFAULT_KEY1" = "DEFAULT_VAL1"
  }
}

resource "azurerm_windows_web_app" "app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  service_plan_id     = azurerm_service_plan.plan-app.id

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }

  app_settings = merge(local.default_app_settings, var.custom_app_settings)

  #app_settings = {"KEY1" = "VAL1", "KEY2" = "VAL2"}

}
