data "azurerm_subnet" "subnet_data" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_public_ip" "pip_data" {
  name                = var.frontend_ip_name
  resource_group_name = var.resource_group_name
}


data "azurerm_key_vault" "kv_data" {
  name                = var.name_kv
  resource_group_name = var.resource_group_name_kv
}

data "azurerm_key_vault_secret" "kv_secret_fronted_username" {
  name         = var.secret_name_username
  key_vault_id = data.azurerm_key_vault.kv_data.id
}

data "azurerm_key_vault_secret" "kv_secret_fronted_password" {
  name         = var.secret_name_password
  key_vault_id = data.azurerm_key_vault.kv_data.id
}