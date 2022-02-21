variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://cloud.ibm.com/docs/overview?topic=overview-locations ."
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The api key."
}

variable "iaas_classic_username" {
  type        = string
  description = "the classic username."
}

variable "iaas_classic_api_key" {
  type        = string
  description = "The classic api key."
}

variable "subnet_cidr_block" {
  type        = string
  description = "The subnet cidr block to use."
  default     = "10.0.1.0/24"
}
