variable "name_db" {
  description = "The name of the SQL database."
  type        = string  
  
} 

variable "name_sql_server" {
  description = "The name of the existing SQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL server is located."
  type        = string
}