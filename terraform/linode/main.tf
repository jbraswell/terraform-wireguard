provider "linode" {
  token = var.linode_token
}

provider "wireguard" {}

terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 1.25.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
