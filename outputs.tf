output "ssh-to-vm" {
  value       = [for vm in module.linux-virtual-machine : "ssh -i '${random_id.this.hex}.pem' jojo@${vm.vm_public_ip}"]
  description = "ssh to VM."
}