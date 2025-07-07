variable "name" {
  type        = string
  description = "The name of the SQL Managed Instance"
  default     = "SQL"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "jojo-rg"
}

variable "managed_instance_name" {
  description = "The name of the SQL Managed Instance"
  type        = string
  default     = "test-sql9"
}

variable "admin_login" {
  description = "The administrator login for the SQL Managed Instance"
  type        = string
  default     = "demosql"
}

variable "admin_password" {
  description = "The administrator password for the SQL Managed Instance"
  type        = string
  default     = "Administrator@20"
  sensitive   = true
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
  default     = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet"
  default     = ["10.0.0.0/24"]
}

variable "sku_name" {
  type        = string
  description = "The sku name"
  default     = "GP_Gen5"
}

variable "storage_size_in_gb" {
  type        = number
  description = "The storage size of the SQL managed instance"
  default     = 256
}

variable "vcores" {
  type        = number
  description = "The vcores"
  default     = 8
}

variable "license_type" {
  type        = string
  description = "The license type of the SQL managed instance"
  default     = "LicenseIncluded"
}

variable "collation" {
  type        = string
  description = "The collation of the SQL managed instance"
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "timezone_id" {
  type        = string
  description = "The id of the timezone"
  default     = "UTC"
}

variable "minimum_tls_version" {
  type        = string
  description = "The minimum tls version"
  default     = "1.2"
}