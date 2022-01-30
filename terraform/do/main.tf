terraform {
  backend "s3" {
    bucket = "jbraswell-tfstate"
    key    = "wireguard-do.tfstate"
    region = "us-east-1"
  }
}

provider "digitalocean" {
  token = var.do_token
}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

data "external" "server_public_key" {
  program = ["${path.module}/../wg-pubkey.sh"]

  query = {
    private_key = var.server_private_key
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
