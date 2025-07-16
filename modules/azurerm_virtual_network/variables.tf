variable "vnet-name" {
    type        = string    
}
variable "vnet-location" {
    type        = string  
}
variable "vnet-address-space" {
    type        = list(string)
}
variable "vnet-resource-group-name" {
    type        = string
}