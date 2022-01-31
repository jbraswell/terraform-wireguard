provider "digitalocean" {
  token = var.do_token
}

provider "wireguard" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    wireguard = {
      source = "OJFord/wireguard"
    }
  }
}
