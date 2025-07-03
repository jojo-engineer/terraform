output "vm_name" {
  value       = azurerm_linux_virtual_machine.jojo-vm.name
  description = "The name of the Linux virtual machine."
}

output "admin_username" {
  value       = azurerm_linux_virtual_machine.jojo-vm.admin_username
  description = "The administrator username for the Linux virtual machine."
}

output "vm_id" {
  value       = azurerm_linux_virtual_machine.jojo-vm.id
  description = "The ID of the Linux virtual machine."
}

output "vm_public_ip" {
  value       = azurerm_linux_virtual_machine.jojo-vm.public_ip_address
  description = "The public IP address of the Linux virtual machine."
}