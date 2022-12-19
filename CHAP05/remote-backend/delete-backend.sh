#!/bin/bash
az storage container delete --account-name "storstate" --name "tfbackends"
az storage account delete --name "storstate" --resource-group "rg_tfstate"
az group delete --name "rg_tfstate"
