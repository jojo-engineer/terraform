resource "azurerm_resource_group" "jojo-rg" {
  name     = "${var.name}-${var.resource_group_name}"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-vnet"
  address_space       = var.address_space
  location            = azurerm_resource_group.jojo-rg.location
  resource_group_name = azurerm_resource_group.jojo-rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.jojo-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "jojo-public-ip" {
  name                = "${var.name}-public-ip"
  resource_group_name = azurerm_resource_group.jojo-rg.name
  location            = azurerm_resource_group.jojo-rg.location
  sku                 = var.sku
  allocation_method   = var.allocation_method
}

resource "azurerm_network_interface" "jojo-nic" {
  name                = "${var.name}-linux-nic"
  location            = azurerm_resource_group.jojo-rg.location
  resource_group_name = azurerm_resource_group.jojo-rg.name

  ip_configuration {
    name                          = "${var.name}-${var.ip_configuration.name}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.jojo-public-ip.id
  }
}

resource "azurerm_network_security_group" "jojo" {
  name                = "${var.name}-nsg"
  location            = azurerm_resource_group.jojo-rg.location
  resource_group_name = azurerm_resource_group.jojo-rg.name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

}

resource "azurerm_subnet_network_security_group_association" "jojo-nsg-association" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.jojo.id
}

resource "azurerm_linux_virtual_machine" "jojo-vm" {
  name                  = "${var.name}-vm"
  resource_group_name   = azurerm_resource_group.jojo-rg.name
  location              = azurerm_resource_group.jojo-rg.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.jojo-nic.id]

  dynamic "admin_ssh_key" {
    for_each = [var.ssh_key]
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  dynamic "os_disk" {
    for_each = [var.disk]
    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }

  dynamic "source_image_reference" {
    for_each = [var.image_reference]
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
}