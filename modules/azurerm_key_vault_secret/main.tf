data "azurerm_key_vault" "kv_data" {
    name                = var.name_kv
    resource_group_name = var.resource_group_name_kv
}


resource "azurerm_key_vault_secret" "kv_secret" {
  name         = var.secret_name
  value        = var.secret_value

  key_vault_id = data.azurerm_key_vault.kv_data.id
} 