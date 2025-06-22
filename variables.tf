variable "vm-name" {
  type        = string
  description = "The name of the windows virtual machine."
  default     = "windowsVM"
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