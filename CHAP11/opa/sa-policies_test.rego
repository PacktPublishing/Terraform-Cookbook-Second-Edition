package terraform.policies.storage


test_without_https {
  not deny with input as {
    "resource_changes": [
    {
      "type": "azurerm_storage_account",
      "address": "azurerm_storage_account.storage",
      "mode": "managed",
      "change": {
        "after": {
            "enable_https_traffic_only": false,
            "name":"test"
        }
      }
    }
    ]
  }
}


test_with_https {
  deny with input as {
    "resource_changes": [
    {
      "type": "azurerm_storage_account",
      "address": "azurerm_storage_account.storage",
      "mode": "managed",
      "change": {
        "after": {
            "enable_https_traffic_only": true,
            "name":"test"
        }
      }
    }
    ]
  }
}