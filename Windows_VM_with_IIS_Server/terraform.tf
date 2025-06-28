terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.31.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id = "app_id"
  client_secret = "app_secret"
  tenant_id = "tenant_id"
  subscription_id = "subscription_id"
}