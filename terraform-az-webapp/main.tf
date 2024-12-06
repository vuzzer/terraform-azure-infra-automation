terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.12.0"
    }
  }
}

provider "azurerm" {
  features{} 
}

// Create resource group called az-tf
resource "azurerm_resource_group" "tf" {
  name = "az-tf"
  location = "canadacentral"
}

// Create resource service plan
resource "azurerm_service_plan" "servicePlan" {
  name = "sp-app"
  resource_group_name = azurerm_resource_group.tf.name
  location = azurerm_resource_group.tf.location
  os_type = "Windows"
  sku_name = "F1"
}


// Create app service plan
resource "azurerm_windows_web_app" "webapp" {
  name = "webapp"
  location = azurerm_resource_group.tf.location
  resource_group_name = azurerm_resource_group.tf.name
  service_plan_id = azurerm_service_plan.servicePlan.id 
  site_config {}
}

// Create SQL Database server
module "Database" {
    source = "../terraform-az-database"
    password = var.password
    login = var.login
}





