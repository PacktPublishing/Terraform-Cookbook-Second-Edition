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
  r.enable_https_traffic_only == false
  msg := sprintf("%v has not enable_https_traffic_only", [az_storage.address])
}

deny[msg] {
  az_storage := azurerm_storage[_]
  r := az_storage.change.after
  r.name != "sademotestopa123"
  msg := sprintf("%v has no name sademotestopa123", [az_storage.name])
}
