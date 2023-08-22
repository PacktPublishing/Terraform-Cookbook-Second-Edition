output "app_service_names" {
  value = azurerm_linux_web_app.app[*].name
}