
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

locals {
  common_app_settings = {
    "INSTRUMENTATIONKEY" = azurerm_application_insights.appinsight-app.instrumentation_key
  }
}

resource "azurerm_resource_group" "rg-app" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  tags = {
    ENV = var.environment
  }
}

resource "azurerm_service_plan" "plan-app" {
  name                = "${var.service_plan_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name

  os_type  = "Linux"
  sku_name = "B1"

  tags = {
    ENV       = var.environment
    CreatedBy = var.createdby
  }
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  service_plan_id     = azurerm_service_plan.plan-app.id

  site_config {}
  app_settings = {
    API_KEY = var.api_key
  }
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
  application_type    = "web"

  tags = {
    ENV       = var.environment
    CreatedBy = var.createdby
  }
}

output "webapp_hostname" {
  description = "hostname of the webapp"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_linux_web_app.app.name
}

output "webapp_password" {
  description = "output credential of the webapp"
  value       = azurerm_linux_web_app.app.site_credential
  sensitive   = true
}