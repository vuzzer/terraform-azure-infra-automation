terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}


# azure provider
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "example_rg" {
  name     = "example-resources"
  location = "Canada Central"
}

# Azure AD provider
resource "azuread_group" "example_group" {
  display_name     = "SecurityTeam"
  security_enabled = true
}

# Azure AD User
resource "azuread_user" "example_user" {
  display_name        = "Peter Pan"
  user_principal_name = "peter.pan@legend225devgmail.onmicrosoft.com"
  mail_nickname       = "peterpan"
  password            = var.password
}

# Azure AD Group Member
resource "azuread_group_member" "example_group_member" {
  group_object_id  = azuread_group.example_group.object_id
  member_object_id = azuread_user.example_user.object_id
}

# Resource for define RBAC role
resource "azurerm_role_assignment" "example_assignment" {
  scope                = azurerm_resource_group.example_rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.example_user.object_id
}