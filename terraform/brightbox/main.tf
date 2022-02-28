provider "brightbox" {
  username = var.username
  password = var.password
  account  = var.account_id
}

provider "wireguard" {}

terraform {
  required_providers {
    brightbox = {
      source  = "brightbox/brightbox"
      version = "~> 2.2"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
