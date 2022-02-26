variable "private_key_path" {
  type        = string
  description = "The path to your private key for remote-exec."
  default     = "~/.ssh/id_rsa"
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}

variable "ssh_user" {
  type        = string
  description = "The ssh user for instance."
  default     = "root"
}

variable "public_ip" {
  type        = string
  description = "The public ip of instance."
}
