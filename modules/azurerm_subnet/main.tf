resource "azurerm_subnet" "todo-subnet" {
  name                 = var.subnet-name
  resource_group_name  = var.subnet-resource-group-name
    virtual_network_name = var.subnet-virtual-network-name
    address_prefixes     = var.subnet-address-prefixes
}