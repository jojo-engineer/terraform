resource "azurerm_resource_group" "joseph-rg" {
  name     = "${var.name}-${var.resource_group_name}"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "testnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "testinternal"
  resource_group_name  = azurerm_resource_group.joseph-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "joseph" {
  name                = "test-pip"
  resource_group_name = azurerm_resource_group.joseph-rg.name
  location            = azurerm_resource_group.joseph-rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "joseph" {
  name                = "network-group"
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name

  ip_configuration {
    name                          = "ip-config"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.joseph.id
  }
}

resource "azurerm_network_security_group" "joseph" {
  name                = "TestSecurityGroup"
  location            = azurerm_resource_group.joseph-rg.location
  resource_group_name = azurerm_resource_group.joseph-rg.name

  security_rule {
    name                       = "test123"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.joseph.id
  network_security_group_id = azurerm_network_security_group.joseph.id
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = "${var.name}VM"
  location              = azurerm_resource_group.joseph-rg.location
  resource_group_name   = azurerm_resource_group.joseph-rg.name
  network_interface_ids = [azurerm_network_interface.joseph.id]
  admin_password        = var.admin_password
  admin_username        = var.admin_username
  computer_name         = var.computer_name
  size                  = var.vm_size

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }
}
