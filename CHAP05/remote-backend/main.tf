terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg_tfstate"
    storage_account_name = "storstate"
    container_name       = "tfbackends"
    key                  = "serviceplan.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}


resource "azurerm_resource_group" "rg-app" {
  name     = "myrg"
  location = "westeurope"
}

resource "azurerm_service_plan" "plan-app" {
  name                = "MyServicePlan"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg-app.name

  os_type  = "Windows"
  sku_name = "S1"
}

output "service_plan_id" {
  description = "ID of the service plan"
  value       = azurerm_service_plan.plan-app.id
}
