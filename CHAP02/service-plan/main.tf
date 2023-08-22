terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.18"
    }
  }
  backend "azurerm" {
    #TFSTATE INFO
  }
}

resource "azurerm_app_service_plan" "plan-app" {
  name                = "MyServicePlan"
  location            = "westeurope"
  resource_group_name = "myrg"

  sku {
    tier = "Standard"
    size = "S1"
  }

}

output "service_plan_id" {
  description = "output Id of the service plan"
  value       = azurerm_app_service_plan.plan-app.id
}
