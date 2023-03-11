
resource "azurerm_resource_group" "rg" {
  name     = "rg-demo"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "sademotest123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only = true

  tags = {
    environment = "demo"
  }
}