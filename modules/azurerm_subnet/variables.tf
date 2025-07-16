variable "subnet-name" {
    type        = string

}
variable "subnet-resource-group-name" {
    type        = string
}
variable "subnet-virtual-network-name" {
    type        = string
}
variable "subnet-address-prefixes" {
    type        = list(string)
}