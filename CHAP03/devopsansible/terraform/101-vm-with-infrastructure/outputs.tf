output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_addresses" {
  value = { for k, v in azurerm_linux_virtual_machine.my_terraform_vm : k => v.public_ip_address }
}
