variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://azure.microsoft.com/en-us/global-infrastructure/geographies/."
}

variable "vpc_cidr_block" {
  type        = string
  description = "The vpc cidr block to use."
  default     = "10.1.0.0/16"
}
