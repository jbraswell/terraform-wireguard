provider "linode" {
  token = var.linode_token
}

provider "wireguard" {}

terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    wireguard = {
      source = "OJFord/wireguard"
    }
  }
}
