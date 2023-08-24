
terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.23"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

variable "virtual_machines" {
  default = [
    {
      dns        = "test1.test.cloud"
      index      = "01"
      address_ip = "0.0.0.1"
    }
  ]
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variable "vmhosts" {
  type    = list(string)
  default = ["vmwebdemo1", "vmwebdemo2"]
}

resource "azurerm_resource_group" "rg" {
  location = "westus"
  name     = "rg-ansible-inventory-${random_string.random.result}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "snet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  vm_os_simple        = "UbuntuServer"
  nb_instances        = 2
  nb_public_ip        = 2
  vm_hostname         = "vmwebdemo-${random_string.random.result}"
  vnet_subnet_id      = azurerm_subnet.snet1.id
  enable_ssh_key      = false
  admin_username      = "adminuser"
  admin_password      = "test123*"
}



resource "local_file" "inventory" {
  filename = "inventory"
  content = templatefile("template-inventory.tpl",
    {
      vm_dnshost = zipmap(var.vmhosts, module.linuxservers.network_interface_private_ip)
  })
}