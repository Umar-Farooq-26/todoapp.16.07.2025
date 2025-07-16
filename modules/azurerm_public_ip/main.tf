resource "azurerm_public_ip" "todo-pip" {
  name                = var.pip-name
  resource_group_name = var.pip-rg
  location            = var.pip-location
  allocation_method   = "Static"
}