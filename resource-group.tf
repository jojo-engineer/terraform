# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

# - resource group name: technology-joseph-learning
# - region: eastus 2
# - tag: Name: Joseph Learning


################ Resource Group ################
resource "azurerm_resource_group" "joseph-rg" {
  name     = "technology-joseph-learning"
  location = "East US 2"
  tags = {
    Name = "Joseph Learning"
  }
}