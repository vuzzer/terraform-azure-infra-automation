terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}


provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "tfGroup" {
  name     = "az104-rg1"
  location = "canadacentral"
}

resource "azurerm_mssql_server" "sqlServer" {
  name                         = "server-event"
  resource_group_name          = azurerm_resource_group.tfGroup.name
  location                     = azurerm_resource_group.tfGroup.location
  version                      = "12.0"
  administrator_login          = var.login
  administrator_login_password = var.password
}


