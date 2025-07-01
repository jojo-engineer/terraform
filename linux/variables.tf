variable "name" {
  type        = string
  description = "The name of the windows virtual machine."
  default     = "linux"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
  default     = "resource-group"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
  default     = "East US 2"
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
  default     = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  type        = list(string)
  description = "The address prefixes for the subnet."
  default     = ["10.0.2.0/24"]
}

variable "ip_configuration" {
  type = object({
    name                          = string
    private_ip_address_allocation = string
    subnet_id                     = string
    public_ip_address_id          = string
  })
  description = "Configuration for the network interface IP."
  default = {
    name                          = "ip-config"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
    subnet_id                     = null
  }
}

variable "sku" {
  type        = string
  description = "The SKU for the public IP address."
  default     = "Standard"
}

variable "allocation_method" {
  type        = string
  description = "The allocation method for the public IP address."
  default     = "Static"
}

variable "size" {
  type        = string
  description = "The size of the virtual machine."
  default     = "Standard_F2"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the virtual machine."
  default     = "jojo"
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  description = "Configuration for the OS disk."
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
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
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "List of security rules for the network security group."
  default = [
    {
      name                       = "Allow-SSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

}