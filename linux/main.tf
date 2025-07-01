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
  for_each = toset([
    "${var.name}-vm-1",
    "${var.name}-vm-2",
  ])
  name                = "${var.name}-public-ip-${each.value}"
  resource_group_name = azurerm_resource_group.jojo-rg.name
  location            = azurerm_resource_group.jojo-rg.location
  sku                 = var.sku
  allocation_method   = var.allocation_method
}

resource "azurerm_network_interface" "jojo-nic" {
  for_each = toset([
    "${var.name}-vm-1",
    "${var.name}-vm-2",
  ])
  name                = "linux-nic-${each.value}"
  location            = azurerm_resource_group.jojo-rg.location
  resource_group_name = azurerm_resource_group.jojo-rg.name

  ip_configuration {
    name                          = "${var.name}-${var.ip_configuration.name}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.jojo-public-ip[each.value].id
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
  for_each = toset([
    "${var.name}-vm-1",
    "${var.name}-vm-2",
  ])
  name                  = each.value
  resource_group_name   = azurerm_resource_group.jojo-rg.name
  location              = azurerm_resource_group.jojo-rg.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.jojo-nic[each.value].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.private_key.public_key_openssh
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "terraform_data" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${tls_private_key.private_key.private_key_pem}' > ./'${random_id.this.hex}'.pem
        chmod 400 ./'${random_id.this.hex}'.pem
      EOT
  }
}

resource "random_id" "this" {
  byte_length = 1
}