module "rg" {
  source = "../modules/azurerm_resource_group"

  name-rg     = "todo-rg"
  location-rg = "uk south"
}

module "rg1" {
  source = "../modules/azurerm_resource_group"

  name-rg     = "todo-rg1"
  location-rg = "uk south"
}

module "vnet" {
  source     = "../modules/azurerm_virtual_network"
  depends_on = [module.rg]

  vnet-name                = "todoVnet"
  vnet-location            = "uk south"
  vnet-address-space       = ["10.0.0.0/16"]
  vnet-resource-group-name = "todo-rg"
}

module "subnet-fronted" {
  source     = "../modules/azurerm_subnet"
  depends_on = [module.vnet]

  subnet-name                 = "todo-fronted"
  subnet-resource-group-name  = "todo-rg"
  subnet-virtual-network-name = "todoVnet"
  subnet-address-prefixes     = ["10.0.100.0/24"]
}

module "subnet-backend" {
  source     = "../modules/azurerm_subnet"
  depends_on = [module.vnet]

  subnet-name                 = "todo-backend"
  subnet-resource-group-name  = "todo-rg"
  subnet-virtual-network-name = "todoVnet"
  subnet-address-prefixes     = ["10.0.200.0/24"]
}

module "sql_server" {
  source     = "../modules/azurerm_sql_server"
  depends_on = [module.rg]

  sql_server_name     = "todosqlserver1234"
  resource_group_name = "todo-rg"
  location            = "uk south"
  sql_login           = "sqladminuser" 
  sql_password        = "SecurePassword123!" # This should be a secure value, consider using a more secure method to set this value
}

module "sql_database" {
  source     = "../modules/azurerm_sql_database"
  depends_on = [module.sql_server]

  name_db             = "todoDB"
  name_sql_server     = "todosqlserver1234"
  resource_group_name = "todo-rg"
}

module "pip-fronted" {
  source     = "../modules/azurerm_public_ip"
  depends_on = [module.rg]

  pip-name     = "todo-pip-fronted"
  pip-rg       = "todo-rg"
  pip-location = "uk south"
}


module "vm-fronted" {
  source     = "../modules/azurerm_virtual_machine_linux"
  depends_on = [module.rg, module.subnet-fronted, module.pip-fronted]

  name-nic                = "todo-nic-fronted"
  location-nic            = "uk south"
  resource_group_name-nic = "todo-rg"
  name-vm                 = "todo-fronted-vm"
  resource_group_name-vm  = "todo-rg"
  location-vm             = "uk south"
  size-vm                 = "Standard_B1s"
  image_publisher         = "Canonical"
  image_offer             = "0001-com-ubuntu-server-jammy"
  image_sku               = "22_04-lts"
  image_version           = "latest"
  frontend_subnet_name    = "todo-fronted"
  vnet_name               = "todoVnet"
  resource_group_name     = "todo-rg"
  frontend_ip_name        = "todo-pip-fronted"
  name_kv                 = "todo-kv"
  resource_group_name_kv  = "todo-rg"
  secret_name_username    = "todo-vm-username"
  secret_name_password    = "todo-vm-password"
}

# module "pip-backend" {
#   source     = "../modules/pip"
#   depends_on = [module.rg]

#   pip-name     = "todo-pip-backend"
#   pip-rg       = "todo-rg"
#   pip-location = "uk south"
# }

# module "vm-backend" {
#   source     = "../modules/vm"
#   depends_on = [module.subnet-backend, module.pip-backend]

#   name-nic                = "todo-nic-backend"
#   location-nic            = "uk south"
#   resource_group_name-nic = "todo-rg"
#   name-vm                 = "todo-backend-vm"
#   resource_group_name-vm  = "todo-rg"
#   location-vm             = "uk south"
#   size-vm                 = "Standard_B1s"
#   image_publisher         = "Canonical"
#   image_offer             = "0001-com-ubuntu-server-focal"
#   image_sku               = "20_04-lts"
#   image_version           = "latest"
#   frontend_subnet_name    = "todo-backend"
#   vnet_name               = "todoVnet"
#   resource_group_name     = "todo-rg"
#   frontend_ip_name        = "todo-pip-backend"
# }


module "kv" {
  source                 = "../modules/azurerm_key_vault"
  depends_on             = [module.rg]
  
  name_kv                = "todo-kv"
  location_kv            = "uk south"
  resource_group_name_kv = "todo-rg"
} 

module "kv_secret_fronted_username" {
  source     = "../modules/azurerm_key_vault_secret"
  depends_on = [module.kv, module.vm-fronted]

  secret_name            = "todo-vm-username01"
  secret_value           = "adminuser1234" # This should be a secure value, consider using a more secure method to set this value
  name_kv                = "todo-kv"
  resource_group_name_kv = "todo-rg"

}

module "kv_secret_fronted_password" {
  source     = "../modules/azurerm_key_vault_secret"
  depends_on = [module.kv, module.vm-fronted]

  secret_name            = "todo-vm-password01"
  secret_value           = "Pakistan1947" # This should be a secure value, consider using a more secure method to set this value
  name_kv                = "todo-kv"
  resource_group_name_kv = "todo-rg"
}