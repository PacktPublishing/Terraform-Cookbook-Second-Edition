terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.35"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
}


module "linuxservers" {
  source              = "Azure/compute/azurerm"
  version             = "5.3.0"
  resource_group_name = var.resource_group_name
  vm_os_simple        = "UbuntuServer"
  vnet_subnet_id      = data.azurerm_subnet.subnet.id
  enable_ssh_key      = false
  admin_username      = "adminuser"
  admin_password      = "test123*"
}