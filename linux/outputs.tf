output "name" {
  value       = [for vm in azurerm_linux_virtual_machine.jojo-vm : vm.name]
  description = "The name of the Linux virtual machine."
}

output "admin_username" {
  value       = [for vm in azurerm_linux_virtual_machine.jojo-vm : vm.admin_username]
  description = "The administrator username for the Linux virtual machine."
}

output "vm_id" {
  value       = [for vm in azurerm_linux_virtual_machine.jojo-vm : vm.id]
  description = "The ID of the Linux virtual machine."
}

output "vm_public_ip" {
  value       = [for vm in azurerm_linux_virtual_machine.jojo-vm : vm.public_ip_address]
  description = "The public IP address of the Linux virtual machine."
}

output "ssh-into-vm" {
  value = [for vm in azurerm_linux_virtual_machine.jojo-vm : "ssh -i ./${random_id.this.hex}.pem jojo@${vm.public_ip_address}"]

}