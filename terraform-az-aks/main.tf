resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

resource "random_pet" "azure_log_analytics_cluster" {
  prefix = "aks-log"
}

// Create resource group
resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

// Create Log Analytics workspace for k8s
resource "azurerm_log_analytics_workspace" "aks_logs" {
  name                = random_pet.azure_log_analytics_cluster.id
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags = {
    Environment = var.environment
  }
}

// Create cluster with 3 node by default
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  # Integrate with Azure Monitor
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_logs.id
  }

  tags = {
    Environment = var.environment
  }
}




