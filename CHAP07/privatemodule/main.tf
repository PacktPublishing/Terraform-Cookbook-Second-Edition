
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-app" {
  name     = "RG_MyAPP_Demo2"
  location = "West Europe"
}

module "webapp" {
  source              = "git@ssh.dev.azure.com:v3/BookLabs/Terraform-modules/terraform-azurerm-webapp"
  service_plan_name   = "spmyapp2"
  app_name            = "myappdemobook2"
  location            = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
}

output "webapp_url" {
  value = module.webapp.webapp_url
}