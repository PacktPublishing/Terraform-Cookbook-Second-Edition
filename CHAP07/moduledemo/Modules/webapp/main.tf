

resource "azurerm_service_plan" "plan-app" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan-app.id
  site_config {}
}

resource "azurerm_application_insights" "appinsight-app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}
