resource "tls_private_key" "private_key" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}