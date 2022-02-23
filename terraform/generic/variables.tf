variable "private_key_path" {
  type        = string
  description = "The path to your private key for remote-exec."
  default     = "~/.ssh/id_rsa"
}

variable "nic" {
  type        = string
  description = "The network interface to use on instance."
  default     = "eth0"
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
