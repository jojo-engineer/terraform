# Example Terraform configuration for Azure SQL Managed Instance

provider "azurerm" {
  features {}
  subscription_id = "a9c1f0e0-6971-483e-97d9-f1f6289373e1"
}

resource "azurerm_resource_group" "SQL-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-vnet"
  address_space       = var.address_space
  location            = azurerm_resource_group.SQL-rg.location
  resource_group_name = azurerm_resource_group.SQL-rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.name}-subnet"
  resource_group_name  = azurerm_resource_group.SQL-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.address_prefixes

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_mssql_managed_instance" "sql-mi" {
  name                         = var.managed_instance_name
  resource_group_name          = azurerm_resource_group.SQL-rg.name
  location                     = azurerm_resource_group.SQL-rg.location
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  subnet_id                    = azurerm_subnet.internal.id

  sku_name                     = var.sku_name
  storage_size_in_gb           = var.storage_size_in_gb
  vcores                       = var.vcores
  license_type                 = var.license_type
  collation                    = var.collation
  timezone_id                  = var.timezone_id
  public_data_endpoint_enabled = false
  minimum_tls_version          = var.minimum_tls_version
  tags = {
    environment = "example"
  }
}