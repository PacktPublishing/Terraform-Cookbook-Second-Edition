#!/bin/bash
az group create --name "rg_tfstate" --location "westeurope"
az storage account create --name "storstate" --resource-group "rg_tfstate" --location "westeurope"
az storage container create --account-name "storstate" --name "tfbackends"
