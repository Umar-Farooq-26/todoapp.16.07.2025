
resource "azurerm_mssql_database" "todoDB" {
  name         = var.name_db
  server_id    = data.azurerm_mssql_server.todo_server_existing.id
  max_size_gb  = 2
  sku_name     = "S0"
}