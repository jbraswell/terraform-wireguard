variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm."
}

variable "tenancy_ocid" {
  type        = string
  description = "OCID of your root tenancy."
}

variable "config_file_profile" {
  type        = string
  description = "The named config file profile."
  default     = "DEFAULT"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The vpc cidr block to use."
  default     = "10.1.0.0/16"
}
