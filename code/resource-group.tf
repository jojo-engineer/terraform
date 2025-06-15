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

################ Import Resource Group ################
# terraform import azurerm_resource_group.example /subscriptions/a9c1f0e0-6971-483e-97d9-f1f6289373e1/resourceGroups/technology-joseph

# resource "azurerm_resource_group" "example" {
#   name = "technology-joseph"
#   location = "East US 2"
#   tags = {
#     Name = "Joseph Learning"
#   }
# }