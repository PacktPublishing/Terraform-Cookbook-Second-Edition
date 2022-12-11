terraform {
  required_version = ">= 1.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.29.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}
