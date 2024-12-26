resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource" "ssh_public_key" {
  for_each  = azurerm_resource_group.rg
  type      = "Microsoft.Compute/sshPublicKeys@2024-07-01"
  name      = "ssh-${replace(each.key, " ", "")}"
  location  = each.value.location
  parent_id = each.value.id
}


resource "azapi_resource_action" "ssh_public_key_gen" {
  for_each               = azapi_resource.ssh_public_key
  type                   = "Microsoft.Compute/sshPublicKeys@2024-07-01"
  resource_id            = each.value.id
  action                 = "generateKeyPair"
  method                 = "POST"
  response_export_values = ["publicKey", "privateKey"]
}
