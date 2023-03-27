package terraform.policies.storage

import input as plan

azurerm_storage[resources] {
	resources := plan.resource_changes[_]
	resources.type == "azurerm_storage_account"
	resources.mode == "managed"
}


deny[msg] {
  az_storage := azurerm_storage[_]
  r := az_storage.change.after
  not r.enable_https_traffic_only
  msg := sprintf("Storage Account %v must use HTTPS traffic only", [az_storage.name])
}

deny[msg] {
  az_storage := azurerm_storage[_]
  r := az_storage.change.after
  r.name != "sademotestopa123"
  msg := sprintf("Storage Account %v must be named sademotestopa123", [az_storage.name])
}

