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

data "http" "ip" {
  url = "https://ifconfig.me/all.json"

  request_headers = {
    Accept = "application/json"
  }
}

locals {
  myip = "${jsondecode(data.http.ip.body).ip_addr}/32"
}
