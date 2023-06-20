terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.35"
    }
  }
    cloud {
    hostname     = "app.terraform.io"
    organization = "demoBook"

    workspaces {
      name = "WebApp"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-demoinfracostor"
  location = "West Europe"
}

resource "azurerm_service_plan" "plan-app" {
  name                = "splaninfracostor"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "webappdemobook1001cor"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan-app.id

  site_config {}
}
