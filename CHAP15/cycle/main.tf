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

provider "azurerm" {
  features {}
}

locals {
  vmname = "vmdemo-${random_string.str.result}"
}

resource "random_string" "str" {
  length  = 4
  special = false
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-VM-${random_string.str.result}"
  location = "East US"
}

resource "azurerm_public_ip" "ip" {
  name                = "${local.vmname}-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

data "azurerm_subnet" "subnet" {
  name                 = "Default1"
  resource_group_name  = "RG_NETWORK"
  virtual_network_name = "VNET-DEMO"
}

resource "azurerm_network_interface" "nic" {
  name = "${azurerm_linux_virtual_machine.vm.name}-nic" #error
  #name                = "${local.vmname}-nic" #correct
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "myvmdemo-${random_string.str.result}"
  network_interface_ids           = [azurerm_network_interface.nic.id]
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = random_password.password.result
  disable_password_authentication = false


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]

    connection {
      host     = self.public_ip_address
      user     = self.admin_username
      password = self.admin_password
    }
  }
}