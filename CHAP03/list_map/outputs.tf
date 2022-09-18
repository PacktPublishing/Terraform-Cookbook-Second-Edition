output "app_service_names" {
  value = [for app in azurerm_linux_web_app.app : app.name]
}

output "app_service_urls" {
  value = { for app in azurerm_linux_web_app.app : app.name => app.default_hostname }
}