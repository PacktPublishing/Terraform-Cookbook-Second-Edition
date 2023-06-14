terraform {
  required_version = "~> 1.1"
  required_providers {
    azurerm = {
      version = "~> 3.23"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = "RG-VMDEMOTFC"
}
data "azurerm_subnet" "subnet" {
  name                 = "book"
  resource_group_name  = "RG-VMDEMOTFC"
  virtual_network_name = "vnetdemo"
}

resource "azurerm_public_ip" "ip" {
  name                = "vmdemo-pip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}



resource "azurerm_network_interface" "nic" {
  name                = "vmdemo-nic"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}


data "azurerm_key_vault" "keyvault" {
  name                = "keyvdemobook"
  resource_group_name = "rg_keyvault"
}

data "azurerm_key_vault_secret" "vm-password" {
  name         = "vmdemoaccess"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "myvmdemo"
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = data.azurerm_key_vault_secret.vm-password.value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic.id]

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

}