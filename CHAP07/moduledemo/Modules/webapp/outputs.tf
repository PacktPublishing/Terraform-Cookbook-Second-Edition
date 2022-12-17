output "webapp_id" {
  value = azurerm_linux_web_app.app.id
}

output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname
}