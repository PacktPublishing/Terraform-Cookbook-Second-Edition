output "https_enabled" {
  value = azurerm_storage_account.storage.enable_https_traffic_only
}

output "storage_name" {
  value = azurerm_storage_account.storage.name
}