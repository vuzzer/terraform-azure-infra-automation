# Create resource group in each azure area
resource "azurerm_resource_group" "rg" {
  for_each = toset(var.region)
  name     = "rg-${replace(each.key, " ", "")}"
  location = each.key
}

# Create storage account with Geo Redundancy Storage in resource group of each area
resource "azurerm_storage_account" "storage" {
  for_each                 = azurerm_resource_group.rg
  name                     = "st99${replace(lower(each.key), " ", "")}"
  resource_group_name      = each.value.name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    Environment = var.Environment
  }
}

# Create virtual network in each region
resource "azurerm_virtual_network" "vnet" {
  for_each            = azurerm_resource_group.rg
  name                = "vnet-${replace(each.key, " ", "")}"
  address_space       = ["10.0.0.0/16"]
  location            = each.value.location
  resource_group_name = each.value.name
}


# create subnet in virtual network of each region
resource "azurerm_subnet" "subnet" {
  for_each             = azurerm_virtual_network.vnet
  name                 = "subnet-${replace(each.key, " ", "")}"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.name
  address_prefixes     = [var.subnet_prefixes[each.key]]
}

# create public ip
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip"
  location            = azurerm_resource_group.rg[var.region[0]].location
  resource_group_name = azurerm_resource_group.rg[var.region[0]].name
  allocation_method   = "Static"
}

# Create network interface for each area 
resource "azurerm_network_interface" "nic" {
  for_each            = azurerm_resource_group.rg
  name                = "nic-${replace(each.key, " ", "")}"
  location            = each.value.location
  resource_group_name = each.value.name

  ip_configuration {
    name                          = "ipconfig-${replace(each.key, " ", "")}"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}


# create vm
resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = azurerm_network_interface.nic
  name                = "vm-${replace(each.key, " ", "")}"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  admin_username      = var.username[each.key]

  network_interface_ids = [each.value.id]

  admin_ssh_key {
    username   = var.username[each.key]
    public_key = azapi_resource_action.ssh_public_key_gen[each.key].output.publicKey
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  size = "Standard_F2"
}

# Load balancer for distributing traffic between VMs
resource "azurerm_lb" "lb" {
  name                = "loadbalancer"
  location            = azurerm_resource_group.rg[var.region[0]].location
  resource_group_name = azurerm_resource_group.rg[var.region[0]].name

  frontend_ip_configuration {
    name                 = "public-lb-ip"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}


