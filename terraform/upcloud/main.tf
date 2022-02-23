provider "upcloud" {
  username = var.upcloud_username
  password = var.upcloud_password
}

provider "wireguard" {}

terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "~> 2.2.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
