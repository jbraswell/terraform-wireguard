variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://www.alibabacloud.com/help/en/doc-detail/89155.htm."
}

variable "access_key" {
  type        = string
  description = "The access key id."
}

variable "secret_key" {
  type        = string
  description = "The secret access key."
}

variable "vpc_cidr_block" {
  type        = string
  description = "The vpc cidr block to use."
  default     = "10.1.0.0/16"
}
