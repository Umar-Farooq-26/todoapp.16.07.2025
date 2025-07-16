variable "secret_name" {
  description = "The name of the secret to be created in the Key Vault."
  type        = string
  
}

variable "secret_value" {
  description = "The value of the secret to be stored in the Key Vault."
  type        = string
}


variable "name_kv" {
  description = "The name of the Key Vault."
  type        = string
}
 
variable "resource_group_name_kv" {
  description = "The name of the resource group where the Key Vault is located."
  type        = string
}