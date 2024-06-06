resource "random_pet" "ssh_key_name" {
  for_each  = local.hosts
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  for_each    = local.hosts
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key[each.key].id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  for_each  = local.hosts
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name[each.key].id
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
}

resource "local_file" "private_key" {
  for_each             = local.hosts
  content              = azapi_resource_action.ssh_public_key_gen[each.key].output.privateKey
  filename             = pathexpand("~/.ssh/private_key_${each.key}.pem")
  directory_permission = "0700"
  file_permission      = "0400"
}

output "key_data" {
  value = { for host in local.hosts : host => azapi_resource_action.ssh_public_key_gen[host].output.publicKey }
}
