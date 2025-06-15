terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.33.0"

    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "a9c1f0e0-6971-483e-97d9-f1f6289373e1"
}