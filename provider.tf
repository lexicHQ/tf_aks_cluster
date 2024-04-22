terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.97.1"
    }
  }
   backend "azurerm" {
      resource_group_name  = "smartlp"
      storage_account_name = "tfstate27010"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

