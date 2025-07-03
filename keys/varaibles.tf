variable "algorithm" {
  type        = string
  description = "the key algorithm"
}

variable "rsa_bits" {
  type        = number
  description = "The rsa bits"
  default     = 4096
}