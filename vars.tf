# Resource Group
variable "dns_rg_name" {
  type    = string
  default = "for_private_dns"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "role_name" {
  type    = string
  default = "CustomPrivateDNSZoneManageRole"
}

variable "description" {
  type    = string
  default = "A custom role with read, write permissions to manage the Private DNS Zone"
}

variable "user_assigned_id_name" {
  type    = string
  default = "private_dns_role"
}