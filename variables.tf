variable "name" {
  type        = string
  description = "The name of the windows virtual machine."
  default     = "windows"
}

variable "admin_password" {
  type        = string
  description = "The administrator password for the virtual machine."
  default     = "Administrator@"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the virtual machine."
  default     = "jojo"
}

variable "computer_name" {
  type        = string
  description = "The computer name for the virtual machine."
  default     = "windows"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine."
  default     = "Standard_B1s"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "The source image reference for the virtual machine."
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
  description = "The OS disk configuration for the virtual machine."
  default = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the virtual machine will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the virtual machine will be created."
}

variable "virtual_network_name" {
  type = string
  description = "The name of azure_virtual_network"
  default = "testnetwork"
}

variable "azurerm_subnet_name" {
  type = string
  description = "The name of azurerm_subnet" 
  default = "testinternal" 
}

variable "azurerm_public_ip_name" {
  type = string
  description = "The name of azurerm_public_ip"
  default = "test-pip"
}

variable "azurerm_network_interface_name" {
  type = string
  description = "The name of azurerm_network_interface"
  default = "network-group"
}

variable "ip_configuration_name" {
  type = string
  description = "The name of ip config"
  default = "ip-config"
}

variable "azurerm_network_security_group_name" {
  type = string
  description = "The name of azurerm_network_security_group"
  default = "TestSecurityGroup"
}