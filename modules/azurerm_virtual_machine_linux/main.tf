

resource "azurerm_network_interface" "nic" {
  name                = var.name-nic
  location            = var.location-nic
  resource_group_name = var.resource_group_name-nic

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_data.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip_data.id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.name-vm
  resource_group_name = var.resource_group_name-vm
  location            = var.location-vm
  size                = var.size-vm

  admin_username      = data.azurerm_key_vault_secret.kv_secret_fronted_username.value
  admin_password      = data.azurerm_key_vault_secret.kv_secret_fronted_password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher # Published ID from Azure Marketplace
    offer     = var.image_offer     # Product ID from Azure Marketplace
    sku       = var.image_sku       # Plan ID from Azure Marketplace
    version   = var.image_version   # Version of the image
  }
}