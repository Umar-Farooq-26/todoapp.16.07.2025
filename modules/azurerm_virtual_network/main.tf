resource "azurerm_virtual_network" "todo-vnet" {
  name                = var.vnet-name
  location            = var.vnet-location
  resource_group_name = var.vnet-resource-group-name
  address_space       = var.vnet-address-space
}