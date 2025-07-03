output "ssh-public-key" {
  value       = tls_private_key.private_key.public_key_openssh
  description = "The public key (.pub)"
}

output "ssh-private-key" {
  value       = tls_private_key.private_key.private_key_pem
  description = "The private key (.pem)"
}