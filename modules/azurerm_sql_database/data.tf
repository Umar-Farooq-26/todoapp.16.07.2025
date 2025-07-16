data "azurerm_mssql_server" "todo_server_existing" {
  name                = var.name_sql_server
  resource_group_name = var.resource_group_name
}

