terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

// Create resource group called az-tf
resource "azurerm_resource_group" "tf" {
  name     = "az-tf"
  location = "canadacentral"
}

// Create resource service plan
resource "azurerm_service_plan" "servicePlan" {
  name                = "sp-app"
  resource_group_name = azurerm_resource_group.tf.name
  location            = azurerm_resource_group.tf.location
  os_type             = "Windows"
  sku_name            = "F1"
}


// Create app service plan
resource "azurerm_windows_web_app" "webapp" {
  name                = var.webapp_name
  location            = azurerm_resource_group.tf.location
  resource_group_name = azurerm_resource_group.tf.name
  service_plan_id     = azurerm_service_plan.servicePlan.id
  site_config {
    always_on = false
  }
}

// Setting up Azure Cost Management (Budget)
resource "azurerm_resource_group_cost_management_view" "cost_management" {
  name              = "resourceGroupCostManagementView"
  display_name      = "Resource Group Cost Management View per month"
  chart_type        = "StackedColumn"
  accumulated       = false
  resource_group_id = azurerm_resource_group.tf.id
  report_type       = "Usage"
  timeframe         = "MonthToDate"

  pivot {
    name = "ResourceGroupName"
    type = "Dimension"
  }

  pivot {
    name = "Location"
    type = "Dimension"
  }

  pivot {
    name = "ResourceType"
    type = "Dimension"
  }

  dataset {
    granularity = "Monthly"

    aggregation {
      name        = "totalCost"
      column_name = "Cost"
    }
  }
}

// Create SQL Database server
module "Database" {
  source   = "../terraform-az-database"
  password = var.password
  login    = var.login
}

# Provide the current Azure client configuration
data "azurerm_client_config" "current" {}





